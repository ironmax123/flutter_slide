import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../viewmodel/base_view_model.dart';

class Page1 extends HookConsumerWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(baseViewModelProvider.notifier).hideAppBar();
      });
      return null;
    }, []);

    return Center(
      child: Text('Flutterフォルダブル対応をしよう！', style: TextStyle(fontSize: 64)),
    );
  }
}
