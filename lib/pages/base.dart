import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../viewmodel/base_view_model.dart';
import 'components/app_bar.dart';
import 'page_1.dart';
import 'page_2.dart';
import 'page_3.dart';
import 'page_4.dart';
import 'page_5.dart';
import 'page_6.dart';
import 'page_7.dart';
import 'page_8.dart';
import 'page_9.dart';

class Base extends HookConsumerWidget {
  const Base({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(baseViewModelProvider);
    final viewModel = ref.watch(baseViewModelProvider.notifier);
    final pageController = usePageController(
      initialPage: state.currentPageIndex,
    );
    final focusNode = useFocusNode();

    final pages = [
      const Page1(),
      const Page2(),
      const Page3(),
      const Page4(),
      const Page5(),
      const Page6(),
      const Page7(),
      const Page8(),
      const Page82(),
      const Page83(),
      const Page9(),
    ];

    // Set total pages on mount
    useEffect(() {
      viewModel.setTotalPages(pages.length);
      return null;
    }, []);

    // Sync PageView with state
    useEffect(() {
      if (pageController.hasClients) {
        pageController.animateToPage(
          state.currentPageIndex,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
      return null;
    }, [state.currentPageIndex]);

    // Request focus on mount
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        focusNode.requestFocus();
      });
      return null;
    }, []);

    return Focus(
      focusNode: focusNode,
      autofocus: true,
      onKeyEvent: (node, event) {
        if (event is KeyDownEvent) {
          if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
            viewModel.nextPage();
            return KeyEventResult.handled;
          } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
            viewModel.previousPage();
            return KeyEventResult.handled;
          }
        }
        return KeyEventResult.ignored;
      },
      child: Scaffold(
        appBar: state.isVisible ? PrimaryAppBar(title: state.title) : null,
        body: PageView(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: pages,
        ),
      ),
    );
  }
}
