import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:slides_for_mac/pages/base.dart';
import 'package:flutter/services.dart';
import 'package:slides_for_mac/pages/base2.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  if (args.isNotEmpty && args[0] == 'secondScreen') {
    // Resize logic will be handled via native channel inside Base2 or immediately here
    const channel = MethodChannel('com.example.slides_for_mac/window_control');
    try {
      await channel.invokeMethod('resizeWindow', {'width': 380, 'height': 460});
    } catch (e) {
      print("Failed to resize window: $e");
    }
    runApp(const MaterialApp(home: Base2()));
  } else {
    runApp(const ProviderScope(child: MyApp()));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Base(),
    );
  }
}
