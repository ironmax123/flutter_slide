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
                  Gap(8),
                  Text(
                    'GitHub: @ironmax123 \n Zenn: @tolto',
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
                Gap(55),
                PrimaryText(text: '高校が少し特殊で授業でJavaをやってたので高校生の頃からAndroidアプリ開発'),
                Gap(8),
                PrimaryText(
                  text:
                      'Java/XMLをやったあとに大学に入ってUdemyを徘徊してたらFlutterを見つけてFlutterを始める',
                ),
                Gap(16),
                PrimaryText(
                  text:
                      'AI時代以前からずっとAndroid Studioを使っててだんだん性能が足りなくなりMacの性能不足で買い換える前は一瞬VScodeで開発していた',
                ),
                Gap(8),
                PrimaryText(text: 'web系の開発は基本VScodeで開発してた'),
              ],
            ),
          ),
          // Expanded(
          //   flex: 1,
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Gap(24),
          //       PrimaryText(text: 'ここ1年半くらいは主にFlutterで開発'),
          //       Gap(55),
          //       PrimaryText(text: '高校が少し特殊で授業でJavaをやってたので高校生の頃からAndroidアプリ開発'),
          //       Gap(8),
          //       PrimaryText(
          //         text:
          //             'Java/XMLをやったあとに大学に入ってUdemyを徘徊してたらFlutterを見つけてFlutterを始める',
          //       ),
          //       Gap(8),
          //       PrimaryText(
          //         text: '学習開始2週間くらいでのりで参加したFlutterのイベントでご縁がありぽちぽちのつどいに入る',
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
