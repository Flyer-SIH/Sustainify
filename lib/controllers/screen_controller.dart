import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ScreenController extends GetxController {
  Rx<int> screen_index = 2.obs;
  late GoogleMapController mapController;
  late RxMap<MarkerId, Marker> markers = {
    MarkerId("initial"): const Marker(markerId: MarkerId("Hello World"))
  }.obs;
  CameraPosition cameraPosition =
      CameraPosition(target: LatLng(45.521563, -122.677433), zoom: 11);
  var image;
  int prev = 0;

  var data = [];

  @override
  void onInit() async {
    super.onInit();
    await setImage();

    LocationPermission permission;
    permission = await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var url =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?keyword=recycle&location=${position.latitude.toString()}%2C${position.longitude.toString()}&radius=50000&key=AIzaSyCwYWsLSig5gbymNTstLvy35b7XG_GG72Q';
    print(url);
    var request = http.Request('GET', Uri.parse(url));
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var pos = jsonDecode(await response.stream.bytesToString());
      pos = pos["results"];
      for (var x in pos) {
        data.add({
          x["name"]: [
            x["geometry"]["location"]["lat"],
            x["geometry"]["location"]["lng"]
          ]
        });
      }
    setRecycleCenterMarkers(data);
    LatLng newlatlang = LatLng(position.latitude, position.longitude);
    mapController?.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: newlatlang, zoom: 10)));
    cameraPosition = CameraPosition(target: newlatlang, zoom: 10);
    } else {
      print(response.reasonPhrase);
    }

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
