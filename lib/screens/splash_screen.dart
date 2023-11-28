import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/screen_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});
  ScreenController screenController = Get.find<ScreenController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
    );
  }
}