import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sustainify/controllers/screen_controller.dart';

class MapScreen extends StatelessWidget {
  MapScreen({super.key});
  var screenController = Get.find<ScreenController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Obx(
        () => GoogleMap(
          zoomControlsEnabled: true,
          initialCameraPosition: screenController.cameraPosition,
          mapType: MapType.terrain,
          onMapCreated: (GoogleMapController controller) {
            screenController.mapController = controller;
                              // Navigate to users current location
      screenController.mapController?.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: screenController.newlatlang, zoom: 10)));
          },
          markers: Set<Marker>.of(screenController.markers.value.values),
        ),
      ),
    );
  }
}
