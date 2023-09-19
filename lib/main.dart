import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'bindings/initial_bindings.dart';
import 'controllers/screen_controller.dart';
import 'screens/awareness_screen.dart';
import 'screens/best_from_waste_screen.dart';
import 'screens/map_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/trash_scan_screen.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Sustainify',
        initialBinding: InitialBindings(),
        initialRoute: "/home",
        theme: ThemeData(
          colorScheme:
              ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 79, 177, 83)),
        ),
        routes: {
          '/home': (context) => MyHomePage(),
        });
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  ScreenController screenController = Get.find<ScreenController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: const Color.fromARGB(255, 247, 243, 243),
        body: screenController.screen_index.value == 0
            ? AwarenessScreen()
            : screenController.screen_index.value == 1
                ? BestFromWasteScreen()
                : screenController.screen_index.value == 2
                    ? MapScreen()
                    : screenController.screen_index.value == 3
                        ? ProfileScreen()
                        : TrashScanScreen(),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.qr_code_scanner,
            color: Colors.white,
          ),
          onPressed: () {
            print("help");
            screenController.screen_index.value = 4;
          },
          backgroundColor: Colors.green,
          //params
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: AnimatedBottomNavigationBar(
          icons: [
            Icons.newspaper,
            Icons.recycling_rounded,
            Icons.location_on,
            Icons.person_2_rounded
          ],
          activeIndex: screenController.screen_index.value,
          activeColor: Color.fromARGB(255, 88, 153, 80),
          inactiveColor: Color.fromARGB(255, 69, 71, 69),
          gapLocation: GapLocation.center,
          notchSmoothness: NotchSmoothness.smoothEdge,
          leftCornerRadius: 32,
          rightCornerRadius: 32,
          onTap: (index) => {screenController.screen_index.value = index},
        ),
      ),
    );
  }
}
