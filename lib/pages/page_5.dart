import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:slides_for_mac/pages/components/text.dart';
import 'package:slides_for_mac/viewmodel/base_view_model.dart';

class Page5 extends HookConsumerWidget {
  const Page5({super.key});

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
          PrimaryText(text: 'フォルダブルスマホで表示したいFoldableScreenを実装する'),
          Gap(8),
          PrimaryText(
            text: 'FoldableScreenで先ほど定義したAscreenBodyとBscreenBodyを呼び出す',
          ),
          Gap(8),
          PrimaryText(text: '既存の画面やVMを再利用することができるので工数を削減できる'),
          Gap(8),
          PrimaryText(
            text: 'ViewModelやフォルダブルスクリーンと通常画面を切り替えるConsumerWidgetを定義する',
          ),
          Gap(8),
          PrimaryText(text: 'この構成だとMVVM + Repositoryパターンを逸脱せず実装できる'),
          Gap(8),
          PrimaryText(text: '   → コンポーネントとVMが1対1で新しい画面でラップしなおしただけと解釈できる'),
          Gap(16),
          Image.asset('assets/images/page_5-1.png', width: 400),
        ],
      ),
    );
  }
}
