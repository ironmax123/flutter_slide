import 'package:flutter/material.dart';

class PrimaryAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const PrimaryAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: const TextStyle(fontSize: 44)),
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      toolbarHeight: 80,
    );
  }

  // Scaffoldが高さを計算できるようにする
  @override
  Size get preferredSize => const Size.fromHeight(80);
}
