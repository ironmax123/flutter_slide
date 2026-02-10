import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:qr_flutter/qr_flutter.dart';

import 'package:slides_for_mac/service/server_state_service.dart';

class Base2 extends HookConsumerWidget {
  const Base2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const hostname = '0.0.0.0';
    final portController = useTextEditingController(text: '8000');
    final server = useState<ServerSocket?>(null);
    final clientMsg = useState<String>('');
    final isStarted = useState(false);
    final isConnected = useState(false);
    final clients = useRef<List<Socket>>([]);
    final serverIp = useState<String?>(null);

    Future<void> startServer() async {
      final port = int.tryParse(portController.text) ?? 8000;
      final s = await ServerSocket.bind(hostname, port);
      server.value = s;
      isStarted.value = true;

      serverIp.value = hostname;

      // Notify native layer about the server port
      await ServerStateService.setServerPort(port);

      try {
        server.value?.listen((Socket socket) {
          clients.value.add(socket);
          clientMsg.value =
              'New TCP client ${socket.address.address}:${socket.port} connected.';
          isConnected.value = true;
          try {
            socket.writeln("Connected!!!");
            print("Connected!!!");
          } catch (e) {
            print("Error writing to socket: $e");
          }
          socket.listen(
            (Uint8List data) {
              if (data.length > 0 && data.first == 10) return;
              final msg = String.fromCharCodes(data).trim();
              print('Data from client: $msg');

              // Broadcast to all clients
              for (final client in clients.value) {
                try {
                  client.write(msg);
                } catch (e) {
                  print("Error broadcasting to client: $e");
                }
              }
            },
            onError: (error) {
              print(
                'Error for client ${socket.address.address}:${socket.port}.',
              );
              clients.value.remove(socket);
            },
            onDone: () {
              print(
                'Connection to client ${socket.address.address}:${socket.port} done.',
              );
              clients.value.remove(socket);
            },
          );
        });
      } on SocketException catch (ex) {
        print(ex.message);
      }
    }

    useEffect(() {
      return () {
        server.value?.close();
      };
    }, []);

    return Scaffold(
      appBar: AppBar(title: Text('コントローラーを接続する')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: portController,
                decoration: const InputDecoration(labelText: 'Port'),
                keyboardType: TextInputType.number,
                enabled: !isStarted.value,
              ),
              const SizedBox(height: 16),
              if (!isStarted.value)
                ElevatedButton(
                  onPressed: startServer,
                  child: Text('Start Server'),
                ),
              if (isStarted.value) ...[
                Text('$hostname:${server.value?.port}'),
                Text(
                  'TCP server started at ${server.value?.address.address}:${server.value?.port}',
                ),
                if (serverIp.value != null) ...[
                  const SizedBox(height: 16),
                  QrImageView(
                    data: '${serverIp.value}:${server.value?.port}',
                    version: QrVersions.auto,
                    size: 200.0,
                  ),
                  Text('${serverIp.value}:${server.value?.port}'),
                ],
              ],
              const SizedBox(height: 16),
              if (isConnected.value) Text('Connected!!'),
              if (isConnected.value) Text(clientMsg.value),
            ],
          ),
        ),
      ),
    );
  }
}
