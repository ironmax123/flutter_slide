import 'package:flutter/material.dart';

class PrimaryText extends StatelessWidget {
  final String text;
  const PrimaryText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final fontSize = width / 40 < 20 ? 20.0 : width / 40;

    return Text(
      text,
      style: TextStyle(fontSize: fontSize, color: Colors.black54),
    );
  }
}
