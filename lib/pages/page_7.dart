import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:slides_for_mac/pages/components/text.dart';
import 'package:slides_for_mac/viewmodel/base_view_model.dart';

class Page7 extends HookConsumerWidget {
  const Page7({super.key});

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
          PrimaryText(
            text: 'Providerが定義できればBottomNavigationをNavigationRailにする',
          ),
          Gap(8),
          PrimaryText(text: 'Googleは640px以上の大画面アプリではNavigationRailを推奨している'),
          Gap(40),
          Center(child: Image.asset('assets/images/page_7-1.png')),
        ],
      ),
    );
  }
}
