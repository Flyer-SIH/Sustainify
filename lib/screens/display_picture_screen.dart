import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sustainify/controllers/screen_controller.dart';
import 'package:sustainify/widgets/custom_app_bar.dart';

class DisplayPicture extends StatelessWidget {
  DisplayPicture({super.key});

  ScreenController screenController = Get.find<ScreenController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Submit Picture',
      ),
      body: Stack(children: [
        Align(
          alignment: Alignment.center,
          child: Image.file(File(screenController.pic.path)),
        ),
        Obx(
          () => screenController.isImageSent.value
              ? BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: screenController.isResultFetched.value
                      ? Align(
                          alignment: Alignment.center,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            height: 200,
                            width: 200,
                            child: Center(child: Text("The waste is ")),
                          ))
                      : Center(
                          child: LoadingAnimationWidget.threeRotatingDots(
                              color: Color.fromARGB(255, 150, 75, 0),
                              size: 30)),
                )
              : SizedBox(),
        ),
      ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.upload_file),
          onPressed: () async {
            screenController.isImageSent.value = true;
            await screenController.upload();
          }),
    );
  }
}
