import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:slides_for_mac/model/slide_content.dart';
import 'package:slides_for_mac/pages/components/text.dart';
import 'package:slides_for_mac/viewmodel/base_view_model.dart';
import 'package:video_player/video_player.dart';

class SlidePage extends HookConsumerWidget {
  final SlideContent content;

  const SlidePage({super.key, required this.content});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (content.title.isEmpty) {
          ref.read(baseViewModelProvider.notifier).hideAppBar();
        } else {
          ref.read(baseViewModelProvider.notifier).setTitle(content.title);
        }
      });
      return null;
    }, [content.title]);

    // Layout Dispatcher
    if (content.isMd == true) {
      return _MarkdownLayout(
        content: content.content,
        images: content.images,
        isRow: content.isRow,
      );
    } else if (content.title.isEmpty && content.content.isNotEmpty) {
      return _TitleLayout(text: content.content);
    } else if (content.content == 'DEMO') {
      return const _DemoTitleLayout();
    } else if (content.images != null &&
        content.images!.length == 1 &&
        content.images!.first.endsWith('.mp4')) {
      return _VideoLayout(videoPath: content.images!.first);
    } else if (content.content.isEmpty &&
        content.images != null &&
        content.images!.isNotEmpty) {
      return _ImageGalleryLayout(images: content.images!);
    } else {
      return _StandardLayout(content: content);
    }
  }
}

class _MarkdownLayout extends StatelessWidget {
  final String content;
  final List<String>? images;
  final bool? isRow;
  const _MarkdownLayout({required this.content, this.images, this.isRow});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final fontSize = width / 40 < 20 ? 20.0 : width / 40;
    // Calculate responsive image size
    // For single image: maybe up to 80% width or constrained max width?
    // For multiple images: share the width, e.g. 40% each with gap
    final singleImageWidth = (width * 0.6) - 160;
    final multiImageWidth = (width * 0.4) - 80;

    // Safety check for very small screens
    final effectiveMultiWidth = multiImageWidth < 150 ? 150.0 : multiImageWidth;

    final markdownBody = MarkdownBody(
      data: content,
      styleSheet: MarkdownStyleSheet(
        h1: TextStyle(fontSize: fontSize * 2.0, fontWeight: FontWeight.bold),
        h2: TextStyle(fontSize: fontSize * 1.5, fontWeight: FontWeight.bold),
        h3: TextStyle(fontSize: fontSize * 1.17, fontWeight: FontWeight.bold),
        p: TextStyle(fontSize: fontSize),
        listBullet: TextStyle(fontSize: fontSize),
        tableBody: const TextStyle(fontSize: 20),
        tableHead: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );

    final imageWidget =
        images != null && images!.isNotEmpty
            ? Column(
              children: [
                const Gap(16),
                if (images!.length == 1)
                  Center(
                    child: Image.asset(images!.first, width: singleImageWidth),
                  )
                else
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (var i = 0; i < images!.length; i++) ...[
                        if (i > 0) const Gap(16),
                        Image.asset(images![i], width: effectiveMultiWidth),
                      ],
                    ],
                  ),
              ],
            )
            : const SizedBox.shrink();

    if (isRow == true) {
      final height = MediaQuery.of(context).size.height;
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: markdownBody),
            const Gap(32),
            Expanded(
              child:
                  images != null && images!.isNotEmpty
                      ? SizedBox(
                        height:
                            height * 0.8, // Constrain height to 80% of screen
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (images!.length == 1)
                              Expanded(
                                child: Image.asset(
                                  images!.first,
                                  fit: BoxFit.contain, // Fit within bounds
                                ),
                              )
                            else
                              // For multiple images, we might still have overflow if not careful,
                              // but let's assume wrapping fits or usage reduces size.
                              // If using Wrap, we can't easily Expanded.
                              // Let's keep Wrap as is but inside the SizedBox it will center-align?
                              // Actually Column > Wrap might overflow SizedBox if too big.
                              // Let's make it scrollable or just center.
                              Center(
                                child: Wrap(
                                  spacing: 16,
                                  runSpacing: 16,
                                  alignment: WrapAlignment.center,
                                  children:
                                      images!
                                          .map(
                                            (img) => Image.asset(
                                              img,
                                              width:
                                                  effectiveMultiWidth, // Reuse calculated width
                                            ),
                                          )
                                          .toList(),
                                ),
                              ),
                          ],
                        ),
                      )
                      : const SizedBox.shrink(),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [markdownBody, imageWidget],
      ),
    );
  }
}

class _TitleLayout extends StatelessWidget {
  final String text;
  const _TitleLayout({required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(text, style: const TextStyle(fontSize: 64)));
  }
}

class _DemoTitleLayout extends StatelessWidget {
  const _DemoTitleLayout();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('DEMO', style: TextStyle(fontSize: 64, color: Colors.grey)),
    );
  }
}

class _VideoLayout extends HookWidget {
  final String videoPath;
  const _VideoLayout({required this.videoPath});

  @override
  Widget build(BuildContext context) {
    final controller = useMemoized(
      () => VideoPlayerController.asset(videoPath),
    );
    final isInitialized = useState(false);

    useEffect(() {
      controller.initialize().then((_) {
        isInitialized.value = true;
        controller.setLooping(true);
        controller.play();
      });
      return controller.dispose;
    }, [controller]);

    if (!isInitialized.value) {
      return const Center(child: CircularProgressIndicator());
    }

    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                child: VideoPlayer(controller),
              ),
            ),
          ),
          const Gap(32),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () => controller.play(),
                icon: const Icon(Icons.play_arrow),
                label: const Text('再生'),
              ),
              const Gap(16),
              ElevatedButton.icon(
                onPressed: () => controller.pause(),
                icon: const Icon(Icons.pause),
                label: const Text('停止'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ImageGalleryLayout extends StatelessWidget {
  final List<String> images;
  const _ImageGalleryLayout({required this.images});

  @override
  Widget build(BuildContext context) {
    // Specific layout for Page 8-2 if it matches the image count/names?
    // Or just a generic gallery.
    // The original Page 8-2 was:
    // Row(Column(Image, Row(Image, Image)), Gap, Image, Gap, Image)
    // This is hard to generalize without more metadata.
    // For now, let's do a simple Row of images, or wrap them.

    // Attempting to replicate the specific layout if 5 images are present
    if (images.length == 5) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Image.asset(images[0], width: 150),
              const Gap(8),
              Row(
                children: [
                  Image.asset(images[1], width: 150),
                  const Gap(44),
                  Image.asset(images[2], width: 150),
                ],
              ),
            ],
          ),
          const Gap(44),
          Image.asset(images[3], width: 320),
          const Gap(8),
          Image.asset(images[4], width: 320),
        ],
      );
    }

    return Center(
      child: Wrap(
        spacing: 16,
        runSpacing: 16,
        alignment: WrapAlignment.center,
        children: images.map((img) => Image.asset(img, width: 300)).toList(),
      ),
    );
  }
}

class _StandardLayout extends StatelessWidget {
  final SlideContent content;
  const _StandardLayout({required this.content});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final lines = content.content.split('\n');

    // Calculate responsive image size
    // Similar logic to _MarkdownLayout to keep consistency
    // Max width for single image: 60% of screen
    final singleImageWidth = (width * 0.6);
    // Max width for multiple images:
    // 2 images: 45% of screen each
    // 3 images: 30% of screen each
    // 4+ images: 20% of screen each
    double multiImageWidth = width * 0.2;
    if (content.images != null) {
      if (content.images!.length == 2) {
        multiImageWidth = width * 0.45;
      } else if (content.images!.length == 3) {
        multiImageWidth = width * 0.3;
      }
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...lines.map((line) {
              if (line.contains('|')) {
                final parts = line.split('|');
                return IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PrimaryText(text: parts[0].trim()),
                            const Gap(8),
                          ],
                        ),
                      ),
                      const VerticalDivider(
                        color: Colors.grey,
                        thickness: 1,
                        width: 32,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PrimaryText(
                              text: parts.length > 1 ? parts[1].trim() : '',
                            ),
                            const Gap(8),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [PrimaryText(text: line), const Gap(8)],
              );
            }),
            if (content.images != null && content.images!.isNotEmpty) ...[
              const Gap(16),
              if (content.images!.length == 1)
                Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: singleImageWidth),
                    child: Image.asset(
                      content.images!.first,
                      fit: BoxFit.contain,
                    ),
                  ),
                )
              else
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (var i = 0; i < content.images!.length; i++) ...[
                      if (i > 0) const Gap(16),
                      ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: multiImageWidth),
                        child: Image.asset(
                          content.images![i],
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ],
                ),
            ],
          ],
        ),
      ),
    );
  }
}
