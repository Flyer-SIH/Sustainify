import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sustainify/dummy_data/item_data.dart';
import 'package:sustainify/screens/information_screen.dart';
import 'package:sustainify/screens/rewards_screen.dart';
import 'package:sustainify/widgets/custom_app_bar.dart';

import '../controllers/screen_controller.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  ScreenController screenController = Get.find<ScreenController>();

  @override
  Widget build(BuildContext context) {
    Color tPrimaryColor = Colors.black;
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Profile',
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 30, 16, 16),
          child: Column(
            children: [
              /// -- IMAGE
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(1000),
                        child: Image.network(screenController.session.provider == "google"? screenController.userData['picture']:"https://cloud.appwrite.io/v1/storage/buckets/651994ab068dc6d408bf/files/6519a0443411617586bd/view?project=6516c52b266f1fb10835&mode=admin")),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: tPrimaryColor),
                      child: const Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(screenController.name,
                  style: Theme.of(context).textTheme.headline4),
              Text(screenController.userData['email'],
                  style: Theme.of(context).textTheme.bodyText2),
              const SizedBox(height: 20),

              /// -- BUTTON
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  // onPressed: () => Get.to(() => const UpdateProfileScreen()),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: tPrimaryColor,
                      side: BorderSide.none,
                      shape: const StadiumBorder()),
                  onPressed: () {},
                  child: const SizedBox(
                      height: 45,
                      child: Center(
                          child: Text('Edit Profile',
                              style: TextStyle(color: Colors.white)))),
                ),
              ),
              const SizedBox(height: 30),
              const Divider(),
              const SizedBox(height: 10),

              /// -- MENU
              ProfileMenuWidget(
                  title: "Settings", icon: Icons.settings, onPress: () {}),
              ProfileMenuWidget(
                  title: "Rewards",
                  icon: Icons.wallet,
                  onPress: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                RewardsScreen(items: dummyData)));
                  }),
              ProfileMenuWidget(
                  title: "Organisation",
                  icon: Icons.group_rounded,
                  onPress: () {}),
              const Divider(),
              const SizedBox(height: 10),
              ProfileMenuWidget(
                  title: "Information",
                  icon: Icons.info,
                  onPress: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AboutApp()));
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

extension StringExtensions on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.textColor,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.black.withOpacity(0.1),
        ),
        child: Icon(icon, color: Colors.black),
      ),
      title: Text(title,
          style:
              Theme.of(context).textTheme.bodyText1?.apply(color: textColor)),
      trailing: endIcon
          ? Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.grey.withOpacity(0.1),
              ),
              child: const Icon(Icons.arrow_forward,
                  size: 18.0, color: Colors.grey))
          : null,
    );
  }
}
