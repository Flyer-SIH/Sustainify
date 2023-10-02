import 'package:flutter/material.dart';
import 'package:flutter_ripple/flutter_ripple.dart';
import 'package:get/get.dart';

import '../controllers/screen_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  ScreenController screenController = Get.find<ScreenController>();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/background.png"),
                fit: BoxFit.cover)),
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            SizedBox(
              height: 100,
              width: 100,
              child: Image.asset("assets/images/logo.png"),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Welcome to Sustainify",
              style: TextStyle(
                  fontFamily: 'Imprima', color: Colors.white, fontSize: 24),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Have a great day with us",
              style: TextStyle(
                  fontFamily: 'Imprima', color: Colors.white, fontSize: 12),
            ),
            const SizedBox(
              height: 100,
            ),
            const Text(
              "Login",
              style: TextStyle(
                  fontFamily: 'Dosis', color: Colors.white, fontSize: 40),
            ),
            const SizedBox(
              height: 50,
            ),
            Material(
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                splashColor: Color.fromARGB(255, 150, 75, 0),
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  screenController.signInViaGoogle();
                },
                child: Container(
                  height: 50,
                  width: 220,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(children: [
                      SizedBox(
                        height: 40,
                        width: 40,
                        child: Image.asset("assets/images/google_logo.png"),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Login with Google",
                        style: TextStyle(fontFamily: 'Imprima'),
                      )
                    ]),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Material(
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                splashColor: Color.fromARGB(255, 150, 75, 0),
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  screenController.signInViaAmazon();
                },
                child: Container(
                  height: 50,
                  width: 220,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(children: [
                      SizedBox(
                        height: 40,
                        width: 40,
                        child: Image.asset("assets/images/amazon_logo.png"),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Login with Amazon",
                        style: TextStyle(fontFamily: 'Imprima'),
                      )
                    ]),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
