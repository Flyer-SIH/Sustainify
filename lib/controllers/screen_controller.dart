import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:ui';

import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ScreenController extends GetxController {
  Rx<int> screen_index = 2.obs;
  late GoogleMapController mapController;
  late RxMap<MarkerId, Marker> markers = {
    MarkerId("initial"): const Marker(markerId: MarkerId("Hello World"))
  }.obs;
  var image;
  int prev = 0;

  var data = [
    {
      "Name": [28.4506, 77.5842]
    },
    {
      "Name 1": [28.5439, 77.3331]
    },
    {
      "Name 2": [28.4731, 77.4829]
    },
    {
      "Name 3": [28.4597, 77.4991]
    }
  ];

  @override
  void onInit() async {
    super.onInit();
    await setImage();

    Future.delayed(Duration(seconds: 8), () {
      setRecycleCenterMarkers(data);
      LatLng newlatlang = LatLng(28.4506, 77.5842);
      mapController?.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: newlatlang, zoom: 10)));
    });
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Future<void> setImage() async {
    Uint8List markerIcon =
        await getBytesFromAsset('assets/images/recycleMark.png', 100);
    image = BitmapDescriptor.fromBytes(markerIcon);
  }

  void setRecycleCenterMarkers(List<dynamic> data) {
    for (var entry in data) {
      Marker marker = Marker(
          markerId: MarkerId(entry.keys.first.toString()),
          icon: image,
          infoWindow: InfoWindow(
            anchor: Offset(0.6, 0.5),
            title: entry.keys.first.toString(),
            snippet: entry.values.first.toString(),
          ),
          position: LatLng(entry.values.first[0], entry.values.first[1]));
      markers[MarkerId(entry.keys.first.toString())] = marker;
    }
  }
}
