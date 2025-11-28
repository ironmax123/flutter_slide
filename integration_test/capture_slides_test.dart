import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:slides_for_mac/main.dart'; // Import MyApp

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Capture screenshots of all slides', (WidgetTester tester) async {
    // Define a key for the RepaintBoundary
    final key = GlobalKey();

    // Pump the app wrapped in RepaintBoundary and ProviderScope
    await tester.pumpWidget(
      ProviderScope(child: RepaintBoundary(key: key, child: const MyApp())),
    );
    await tester.pumpAndSettle();

    // Create screenshots directory
    final directory = Directory('/slides_for_mac/screenshots');
    if (directory.existsSync()) {
      directory.deleteSync(recursive: true);
    }
    directory.createSync();

    const totalPages = 11;

    for (int i = 0; i < totalPages; i++) {
      // Wait for animations
      await tester.pumpAndSettle(const Duration(milliseconds: 500));

      try {
        // Capture screenshot using the key
        final boundary =
            key.currentContext?.findRenderObject() as RenderRepaintBoundary?;

        if (boundary != null) {
          // Use a higher pixel ratio for better quality
          final image = await boundary.toImage(pixelRatio: 2.0);
          final byteData = await image.toByteData(
            format: ui.ImageByteFormat.png,
          );
          if (byteData != null) {
            final buffer = byteData.buffer.asUint8List();
            File('/screenshots/slide_${i + 1}.png').writeAsBytesSync(buffer);
            print('Saved slide_${i + 1}.png');
          }
        } else {
          debugPrint('Could not find RepaintBoundary for slide $i');
        }
      } catch (e, stack) {
        debugPrint('Error capturing slide $i: $e');
        debugPrint(stack.toString());
      }

      // Navigate to next page
      if (i < totalPages - 1) {
        await tester.sendKeyEvent(LogicalKeyboardKey.arrowRight);
        await tester.pumpAndSettle();
      }
    }
  });
}
