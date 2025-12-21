import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:slides_for_mac/model/slide_content.dart';
import 'package:slides_for_mac/pages/components/slide_page.dart';

void main() {
  testWidgets('SlidePage renders split view when content contains |', (
    WidgetTester tester,
  ) async {
    const content = SlideContent(
      pageNum: 1,
      title: 'Test Title',
      content: 'Left Side|Right Side',
      images: null,
    );

    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(home: Scaffold(body: SlidePage(content: content))),
      ),
    );

    // Verify that both sides are rendered
    expect(find.text('Left Side'), findsOneWidget);
    expect(find.text('Right Side'), findsOneWidget);

    // Verify that a VerticalDivider is present
    expect(find.byType(VerticalDivider), findsOneWidget);
  });

  testWidgets(
    'SlidePage renders standard view when content does not contain |',
    (WidgetTester tester) async {
      const content = SlideContent(
        pageNum: 1,
        title: 'Test Title',
        content: 'Single Line Content',
        images: null,
      );

      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(home: Scaffold(body: SlidePage(content: content))),
        ),
      );

      // Verify content is rendered
      expect(find.text('Single Line Content'), findsOneWidget);

      // Verify that NO VerticalDivider is present
      expect(find.byType(VerticalDivider), findsNothing);
    },
  );
}
