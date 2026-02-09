import 'package:flutter/material.dart';

class Base2 extends StatelessWidget {
  const Base2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('コントローラーを接続する')),
      body: Column(children: [Text('localhost:3000')]),
    );
  }
}
