import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:sustainify/controllers/screen_controller.dart';
import 'package:sustainify/widgets/custom_app_bar.dart';

class ScanProductScreen extends StatelessWidget {
  ScanProductScreen({super.key});

  ScreenController screenController = Get.find<ScreenController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Scan Product"),
      body: Obx(() => CameraPreview(screenController.cameraController.value)),
    );
  }
}
