import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:ui';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sustainify/models/blogs/models.dart';

class ScreenController extends GetxController {
  Rx<int> screen_index = 0.obs;
  late String result;
  Rx<bool> isResultFetched = false.obs;
  Rx<bool> isImageSent = false.obs;
  late XFile pic;
  late GoogleMapController mapController;
  Rx<bool> isDataFetched = false.obs;
  late LocationPermission permission;
  late List<Articles> fetchedArticles;
  late Position position;
  var responseData;
  late Rx<CameraController> cameraController;
  late List<CameraDescription> _cameras;
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
    fetchedArticles = await fetchArticles();
    await setImage();
    //Get User Location
    permission = await Geolocator.requestPermission();
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    // Get cameras
    _cameras = await availableCameras();
    cameraController = CameraController(_cameras[0], ResolutionPreset.max).obs;
    cameraController.value.initialize();
    getRecycleCenter();
  }

  Future<List<Articles>> fetchArticles() async {
    final response = await http.get(Uri.parse(
        'https://newsapi.org/v2/everything?q="waste management"&pageSize=50&apiKey=bb338facda384c838159a4d50bbdc0e1'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      final List<dynamic> articleList = jsonResponse['articles'];
      isDataFetched.value = true;
      return articleList.map((article) => Articles.fromJson(article)).toList();
    } else {
      throw Exception('Failed to load articles');
    }
  }

  Future<void> getRecycleCenter() async {
    //Generate URL
    var url =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?keyword=recycle&location=${position.latitude.toString()}%2C${position.longitude.toString()}&radius=50000&key=AIzaSyCwYWsLSig5gbymNTstLvy35b7XG_GG72Q';
    print(url);
    var request = http.Request('GET', Uri.parse(url));

    //Make call for fetching
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var pos = jsonDecode(await response.stream.bytesToString());
      pos = pos["results"];
      // format required data
      for (var x in pos) {
        data.add({
          x["name"]: [
            x["geometry"]["location"]["lat"],
            x["geometry"]["location"]["lng"]
          ]
        });
      }
      // set Markers from data
      setRecycleCenterMarkers(data);

      LatLng newlatlang = LatLng(position.latitude, position.longitude);
      // Navigate to users current location
      mapController?.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: newlatlang, zoom: 10)));

      // set new camera position as users current location
      cameraPosition = CameraPosition(target: newlatlang, zoom: 10);
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<void> upload() async {
    print("pressed upload");
    isResultFetched.value = true;
    // var request = http.MultipartRequest(
    //     'POST',
    //     Uri.parse(
    //         "https://backend-production-2203.up.railway.app/api/image-process"));

    // request.files.add(http.MultipartFile(
    //     'file', pic.readAsBytes().asStream(), await pic.length(),
    //     filename: "data.jpeg"));
    // http.StreamedResponse res = await request.send();
    // responseData = jsonDecode(await res.stream.bytesToString());
    // isResultFetched.value = true;
    // print(responseData);
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
