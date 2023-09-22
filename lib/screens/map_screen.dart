import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sustainify/controllers/screen_controller.dart';

class MapScreen extends StatelessWidget {
  MapScreen({super.key});
  final Completer<GoogleMapController> _controller = Completer();
  CameraPosition _cameraPosition = CameraPosition(target: LatLng(28.4506465, 77.5841978), zoom: 7);
  var controller = Get.find<ScreenController>();


  @override
  Widget build(BuildContext context) {
    return Container(
      child: GoogleMap(
        zoomControlsEnabled: true,
        initialCameraPosition: _cameraPosition,
        mapType: MapType.terrain,
        onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
        },
        markers: Set<Marker>.of(controller.markers.values),
        ),
    );
  }
}