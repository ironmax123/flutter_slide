import 'dart:io';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

void main() {
  test('Generate PDF from screenshots', () async {
    final pdf = pw.Document();
    final directory = Directory('screenshots');

    if (!directory.existsSync()) {
      debugPrint(
        'Error: screenshots directory not found. Run integration test first.',
      );
      return;
    }

    // Get all PNG files and sort them
    final files =
        directory
            .listSync()
            .whereType<File>()
            .where((f) => f.path.endsWith('.png'))
            .toList();

    files.sort((a, b) {
      // Extract number from filename "slide_X.png"
      final aNum = int.parse(a.path.split('_').last.split('.').first);
      final bNum = int.parse(b.path.split('_').last.split('.').first);
      return aNum.compareTo(bNum);
    });

    if (files.isEmpty) {
      debugPrint('Error: No screenshots found.');
      return;
    }

    for (final file in files) {
      final image = pw.MemoryImage(file.readAsBytesSync());
      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4.landscape,
          build: (pw.Context context) {
            return pw.Center(child: pw.Image(image, fit: pw.BoxFit.contain));
          },
        ),
      );
    }

    final file = File('slides.pdf');
    await file.writeAsBytes(await pdf.save());
    debugPrint('Successfully generated ${file.path}');
  });
}
