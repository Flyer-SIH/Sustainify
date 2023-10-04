import 'package:flutter/material.dart';
import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sustainify/controllers/screen_controller.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String videoLink;
  const VideoPlayerScreen({super.key, required this.videoLink});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController videoPlayerController;
  late CustomVideoPlayerController _customVideoPlayerController;
  bool isInitialised = false;
  @override
  void initState() {
    super.initState();
    print("Initializing");
    videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.videoLink))
          ..initialize().then((value) => setState(() {
                print("Initialized");
                isInitialised = true;
              }));
    print("Moved Forward");
    _customVideoPlayerController = CustomVideoPlayerController(
      context: context,
      videoPlayerController: videoPlayerController,
    );
  }

  @override
  void dispose() {
    _customVideoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: isInitialised? CustomVideoPlayer(
            customVideoPlayerController: _customVideoPlayerController):Center(child: LoadingAnimationWidget.hexagonDots(color: Color.fromARGB(255, 150, 75, 0), size: 50),),
      ),
    );
  }
}
