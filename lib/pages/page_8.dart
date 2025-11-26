import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:slides_for_mac/viewmodel/base_view_model.dart';

class Page8 extends HookConsumerWidget {
  const Page8({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(baseViewModelProvider.notifier).setTitle('3. アプリにくみこんでみた');
      });
      return null;
    }, []);

    return Center(
      child: Text('DEMO', style: TextStyle(fontSize: 64, color: Colors.grey)),
    );
  }
}
