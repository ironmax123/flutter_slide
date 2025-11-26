import 'package:flutter/material.dart';

class PrimaryImage extends StatelessWidget {
  final String imagePath;
  const PrimaryImage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Image(image: AssetImage(imagePath), fit: BoxFit.cover);
  }
}
