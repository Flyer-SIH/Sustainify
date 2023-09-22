import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ScreenController extends GetxController {
  Rx<int> screen_index = 0.obs;
  Map<MarkerId, Marker> markers = {};
  int prev = 0;
}
