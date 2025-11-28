import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:slides_for_mac/pages/components/text.dart';

import '../viewmodel/base_view_model.dart';

class Page3 extends HookConsumerWidget {
  const Page3({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(baseViewModelProvider.notifier).setTitle('1. 大画面,フォルダブルについて');
      });
      return null;
    }, []);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PrimaryText(text: 'Android XRの登場'),
          Gap(8),
          PrimaryText(text: 'フォルダブルスマホの普及'),
          Gap(8),
          PrimaryText(text: '開発者が意図していないタイミングでのレイアウト崩れもある'),
          Gap(8),
          PrimaryText(text: 'Android 16以降、大画面端末でアスペクト比制限が無視される'),
          Gap(4),
          PrimaryText(text: '  ・minAspectRatio / maxAspectRatioが無効化'),
          Gap(4),
          PrimaryText(text: '  ・画面の向き固定(screenOrientation)も無視される'),
          Gap(4),
          PrimaryText(text: '  ・強制的にリサイズ可能になり、レターボックス(黒帯)が表示されなくなる'),
          Gap(8),
          PrimaryText(text: 'この辺りはDroidKaigi2025で詳しく発表されてました'),
        ],
      ),
    );
  }
}
