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
                            width: 300,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Your waste is "),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color:  screenController.responseData['class'] == "Non-Biodegradable (Non-Recyclable)"? Colors.red: Colors.green,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                      child: Text(
                                    screenController.responseData['class'],
                                    style: TextStyle(color: Colors.white),
                                  )),
                                  height: 60,
                                  width: 280,
                                )
                              ],
                            ),
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
