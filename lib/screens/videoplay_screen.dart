import 'package:flutter/material.dart';
import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sustainify/controllers/screen_controller.dart';

class VideoPlayScreen extends StatelessWidget {
   VideoPlayScreen({super.key});
  ScreenController screenController = Get.find<ScreenController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(
          
        () => screenController.isInitialised.value? CustomVideoPlayer(
              customVideoPlayerController: screenController.customVideoPlayerController):Center(child: LoadingAnimationWidget.hexagonDots(color: Color.fromARGB(255, 150, 75, 0), size: 50),),
        ),
      ),
    );;
  }
}