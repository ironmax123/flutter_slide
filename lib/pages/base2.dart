import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Base2 extends HookConsumerWidget {
  const Base2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text('コントローラーを接続する')),
      body: Column(children: [Text('localhost:3000')]),
    );
  }
}
