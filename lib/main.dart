import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:slides_for_mac/pages/base.dart';
import 'package:window_manager/window_manager.dart';

import 'package:slides_for_mac/pages/base2.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  if (args.isNotEmpty && args[0] == 'secondScreen') {
    await windowManager.setSize(const Size(380, 460));
    runApp(const MaterialApp(home: Base2()));
  } else {
    runApp(ProviderScope(child: const MyApp()));
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
