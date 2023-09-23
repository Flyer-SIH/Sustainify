import 'package:flutter/material.dart';
import 'package:sustainify/widgets/custom_app_bar.dart';

class AboutApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'About App',
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Version'),
            subtitle: Text('1.0.0'),
            leading: Icon(Icons.info),
          ),
          Divider(),
          ListTile(
            title: Text('Contact Us'),
            subtitle: Text('Have a comment, complaint, or suggestion?'),
            leading: Icon(Icons.email),
            onTap: () {
              // Add your email functionality here
            },
          ),
          Divider(),
          ListTile(
            title: Text('Terms of Service'),
            subtitle: Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit...'),
            leading: Icon(Icons.description),
            onTap: () {
              // Add your Terms of Service functionality here
            },
          ),
          Divider(),
          ListTile(
            title: Text('Privacy Policy'),
            subtitle: Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit...'),
            leading: Icon(Icons.security),
            onTap: () {
              // Add your Privacy Policy functionality here
            },
          ),
        ],
      ),
    );
  }
}
