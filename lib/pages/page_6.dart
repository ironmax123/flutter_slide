import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:slides_for_mac/pages/components/text.dart';
import 'package:slides_for_mac/viewmodel/base_view_model.dart';

class Page6 extends HookConsumerWidget {
  const Page6({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(baseViewModelProvider.notifier).setTitle('2. Flutterで対応してみる');
      });
      return null;
    }, []);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PrimaryText(text: '画面を切り替えるために画面サイズを判定するためのProviderを定義する'),
          Gap(8),
          PrimaryText(text: '切り替えの参考画面サイズはGoogleが提唱している600px以上を大画面とする'),
          Gap(8),
          PrimaryText(text: 'また横向きやさらに大きいタブレットなどで対応する場合横は840px以上とする'),
          Gap(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/page_6-1.png', width: 500),
              Gap(16),
              Image.asset('assets/images/page_6-2.png', width: 500),
            ],
          ),
        ],
      ),
    );
  }
}
