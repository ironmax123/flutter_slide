import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:slides_for_mac/pages/components/text.dart';
import 'package:slides_for_mac/viewmodel/base_view_model.dart';

class Page4 extends HookConsumerWidget {
  const Page4({super.key});

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
          PrimaryText(text: '今回作成したのは三画面のアプリ'),
          Gap(8),
          PrimaryText(text: '3画面のうち二画面を大画面対応していく'),
          Gap(8),
          PrimaryText(text: 'bodyプロパティの中全体をコンポーネント化'),
          Gap(8),
          PrimaryText(text: 'ViewModelやStateは普段通り実装する'),
          Gap(40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/page_4-1.png', width: 500),
              Gap(16),
              Image.asset('assets/images/page_4-2.png', width: 320),
            ],
          ),
        ],
      ),
    );
  }
}
