import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:slides_for_mac/model/slide_content.dart';
import 'package:slides_for_mac/pages/components/slide_page.dart';

import '../viewmodel/base_view_model.dart';
import 'components/app_bar.dart';
import 'page_2.dart';

Future<List<SlideContent>> loadSlides() async {
  final jsonString = await rootBundle.loadString('assets/content.json');
  final List<dynamic> jsonList = json.decode(jsonString);
  return jsonList.map((json) => SlideContent.fromJson(json)).toList();
}

class Base extends HookConsumerWidget {
  const Base({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(baseViewModelProvider);
    final viewModel = ref.watch(baseViewModelProvider.notifier);

    final slidesFuture = useMemoized(loadSlides);
    final snapshot = useFuture(slidesFuture);

    final pageController = usePageController(
      initialPage: state.currentPageIndex,
    );
    final focusNode = useFocusNode();

    if (!snapshot.hasData) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final slides = snapshot.data!;
    slides.sort((a, b) => a.pageNum.compareTo(b.pageNum));

    final pages = [
      ...slides.where((s) => s.pageNum < 2).map((s) => SlidePage(content: s)),
      const Page2(),
      ...slides.where((s) => s.pageNum > 2).map((s) => SlidePage(content: s)),
    ];

    // Set total pages on mount (only when pages are ready)
    useEffect(() {
      viewModel.setTotalPages(pages.length);
      return null;
    }, [pages.length]);

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
