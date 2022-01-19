import 'package:flutter/material.dart';
import 'package:library_booking_system/Screens/UserProfile/profile_body.dart';
import 'package:library_booking_system/Services/auth_provider.dart';
import 'package:library_booking_system/Screens/AuthScreen/login.dart';
import '../drawer.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Profile"),
        actions: [
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                //sign Out User
                AuthClass().signOut();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                    (route) => false);
              })
        ],
      ),
      body: ProfileBody(),
      drawer: SideDrawer(),
    );
  }
}
