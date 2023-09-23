import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sustainify/controllers/screen_controller.dart';

class MapScreen extends StatelessWidget {
  MapScreen({super.key});

  CameraPosition _cameraPosition =
      CameraPosition(target: LatLng(45.521563, -122.677433), zoom: 11);
  var screenController = Get.find<ScreenController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Obx(
        () => GoogleMap(
          zoomControlsEnabled: true,
          initialCameraPosition: _cameraPosition,
          mapType: MapType.terrain,
          onMapCreated: (GoogleMapController controller) {
            screenController.mapController = controller;
          },
          markers: Set<Marker>.of(screenController.markers.value.values),
        ),
      ),
    );
  }
}
