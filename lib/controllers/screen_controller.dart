import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:ui';
import 'package:appwrite/models.dart';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import 'package:appwrite/appwrite.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sustainify/main.dart';
import 'package:sustainify/models/blogs/models.dart';
import 'package:sustainify/screens/login_screen.dart';

class ScreenController extends GetxController {
  Rx<int> screen_index = 0.obs;
  late String result;
  late String name;
  var userData;
  Rx<bool> isResultFetched = false.obs;
  Rx<bool> isImageSent = false.obs;
  late XFile pic;
  late Account account;
  late Session session;
  late GoogleMapController mapController;
  late LocationPermission permission;
  late Future<List<Articles>> fetchedArticles;
  late Position position;
  late LatLng newlatlang;
  var responseData;
  late User user;
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
    print("hello");
    Client client = Client();
    client
        .setEndpoint('https://cloud.appwrite.io/v1')
        .setProject('6516c52b266f1fb10835')
        .setSelfSigned(status: true);
    account = Account(client);
    print("Here");
    try {
      session = await account.getSession(sessionId: "current");
      print("Yes Session");
      if (session.provider == "google") {
        fetchGoogleUserProfile();
      } else {
        print("Amazon log in");
        fetchAmazonUserProfile();
      }
      Get.to(MyHomePage());
    } catch (e) {
      print(e);
      Get.to(LoginScreen());
      print("No Session");
    }

    // Fetch Articles
    fetchedArticles = fetchArticles();

    //Get Location Permission
    permission = await Geolocator.requestPermission();

    // Get cameras
    _cameras = await availableCameras();
    cameraController = CameraController(_cameras[0], ResolutionPreset.max).obs;
    cameraController.value.initialize();

    await setImage();

    //Get User Location
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    // Get recycle center
    getRecycleCenter();
  }

  Future<void> signInViaGoogle() async {
    print("Starting Login");
    await account.createOAuth2Session(
        provider: 'google',
        scopes: ["https://www.googleapis.com/auth/userinfo.profile"]);
    print("Fetching Current Session");
    session = await account.getSession(sessionId: "current");
    print("Printing Provider Token");
    print(session.providerAccessToken);
    print("fetching profile");
    fetchGoogleUserProfile();
    Get.to(MyHomePage());
  }

  Future<void> fetchGoogleUserProfile() async {
    var headers = {'Authorization': 'Bearer ${session.providerAccessToken}'};
    var request = http.Request('GET',
        Uri.parse('https://www.googleapis.com/oauth2/v1/userinfo?alt=json'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print("got profile");
      userData = jsonDecode(await response.stream.bytesToString());

      print(userData);
      print(userData["picture"]);
      name =
          userData['name'].split(' ').map((word) => capitalize(word)).join(' ');
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<void> signInViaAmazon() async {
    print("Starting Login");
    await account.createOAuth2Session(provider: 'amazon');
    print("Fetching Current Session");
    session = await account.getSession(sessionId: "current");
    print("Printing Provider Token");
    print(session.providerAccessToken);
    Get.to(MyHomePage());
    print("fetching profile");
    fetchAmazonUserProfile();
  }

  Future<void> fetchAmazonUserProfile() async {
    var headers = {'Authorization': 'Bearer ${session.providerAccessToken}'};
    var request =
        http.Request('GET', Uri.parse('https://api.amazon.com/user/profile'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      userData = jsonDecode(await response.stream.bytesToString());
      print(userData);
      name =
          userData['name'].split(' ').map((word) => capitalize(word)).join(' ');
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<List<Articles>> fetchArticles() async {
    final response = await http.get(Uri.parse(
        'https://newsapi.org/v2/everything?q="waste management"&pageSize=50&apiKey=bb338facda384c838159a4d50bbdc0e1'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      final List<dynamic> articleList = jsonResponse['articles'];
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

      newlatlang = LatLng(position.latitude, position.longitude);

      // set new camera position as users current location
      cameraPosition = CameraPosition(target: newlatlang, zoom: 10);
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<void> upload() async {
    print("pressed upload");
    var request = http.MultipartRequest('POST',
        Uri.parse("https://5dff-182-79-102-194.ngrok-free.app/classify"));

    request.files.add(http.MultipartFile(
        'image', pic.readAsBytes().asStream(), await pic.length(),
        filename: "image.jpg"));
    http.StreamedResponse res = await request.send();
    responseData = jsonDecode(await res.stream.bytesToString());
    isResultFetched.value = true;
    print(responseData["class"]);
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

  String capitalize(String input) {
    return "${input[0].toUpperCase()}${input.substring(1)}";
  }
}
