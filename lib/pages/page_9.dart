import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:slides_for_mac/pages/components/text.dart';
import 'package:slides_for_mac/viewmodel/base_view_model.dart';

class Page9 extends HookConsumerWidget {
  const Page9({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(baseViewModelProvider.notifier).setTitle('4. 感想,まとめ');
      });
      return null;
    }, []);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(100),
          PrimaryText(text: '- 今あるコンポーネントやVMを再利用できるので工数がそこまでかからず実装できる'),
          Gap(16),
          PrimaryText(
            text:
                '- AppBar共通化したかったのでこのような実装になったがScaffoldごとよびだして並べる実装だともっと楽にできると思います',
          ),
          Gap(16),
          PrimaryText(text: '- 全部の画面をやるというよりチャット画面や設定画面など一部の画面を対応させるのが良さそう'),
          Gap(16),
          PrimaryText(text: '- Androidだけじゃなくて2026年後半にはAppleもフォルダブルを出すという噂もある'),
        ],
      ),
    );
  }
}
