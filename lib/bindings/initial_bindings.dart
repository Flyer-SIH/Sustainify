import 'package:get/get.dart';
import 'package:sustainify/controllers/screen_controller.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ScreenController());
  }
}
