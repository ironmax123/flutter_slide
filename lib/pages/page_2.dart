import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:slides_for_mac/pages/components/text.dart';

import '../viewmodel/base_view_model.dart';

class Page2 extends HookConsumerWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(baseViewModelProvider.notifier).setTitle('自己紹介');
      });
      return null;
    }, []);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Gap(24),
              SizedBox(
                width: 260, // ← 横も指定しておく（正円にしたいなら幅 = 高さ）
                height: 260,
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/page_2-2.jpg',
                    fit: BoxFit.cover, // 中央でトリミングして丸にフィット
                  ),
                ),
              ),
              Gap(16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '大阪成蹊大学 データサイエンス学部 B2',
                    style: TextStyle(color: Colors.black54, fontSize: 22),
                  ),
                  Gap(8),
                  Text(
                    'ぽちぽちのつどい/Ale Engineer',
                    style: TextStyle(color: Colors.black54, fontSize: 22),
                  ),
                ],
              ),
            ],
          ),
          Gap(44),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(24),
                PrimaryText(text: 'ここ1年半くらいは主にFlutterで開発'),
                Gap(24),
                PrimaryText(text: 'スマホを愛するあまり、開発の沼にハマったオタク'),
                Gap(55),
                PrimaryText(
                  text:
                      'DroidKaigi2025に参加した時に大画面対応のセッションを見てFlutterでもやってみようとなった',
                ),
                Gap(8),
                PrimaryText(
                  text:
                      '[基礎から学ぶ大画面対応 \n〜「Large screen differentiated」認定アプリの開発知見〜]',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
