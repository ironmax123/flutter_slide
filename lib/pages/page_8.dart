import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:slides_for_mac/viewmodel/base_view_model.dart';
import 'package:video_player/video_player.dart';

class Page8 extends HookConsumerWidget {
  const Page8({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(baseViewModelProvider.notifier).setTitle('3. アプリにくみこんでみた');
      });
      return null;
    }, []);

    return Center(
      child: Text('DEMO', style: TextStyle(fontSize: 64, color: Colors.grey)),
    );
  }
}

class Page82 extends StatelessWidget {
  const Page82({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Image.asset('assets/demo/home-1.png', width: 150),
            Gap(8),
            Row(
              children: [
                Image.asset('assets/demo/saves.png', width: 150),
                Gap(44),
                Image.asset('assets/demo/description-1.png', width: 150),
              ],
            ),
          ],
        ),
        Gap(44),
        Image.asset('assets/demo/open_home.png', width: 320),
        Gap(8),
        Image.asset('assets/demo/open_saves.png', width: 320),
      ],
    );
  }
}

class Page83 extends HookConsumerWidget {
  const Page83({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useMemoized(
      () => VideoPlayerController.asset('assets/demo/video.mp4'),
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
          Gap(32),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () => controller.play(),
                icon: const Icon(Icons.play_arrow),
                label: const Text('再生'),
              ),
              Gap(16),
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
