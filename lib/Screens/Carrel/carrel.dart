import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:library_booking_system/Services/auth_provider.dart';
import 'package:library_booking_system/Screens/AuthScreen/login.dart';
import 'package:library_booking_system/Screens/drawer.dart';
import 'carrel_room.dart';

class Carrel extends StatefulWidget {
  @override
  _CarrelState createState() => _CarrelState();
}

class _CarrelState extends State<Carrel> {
  String user = FirebaseAuth.instance.currentUser.email == null
      ? FirebaseAuth.instance.currentUser.phoneNumber
      : FirebaseAuth.instance.currentUser.email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book Carrel Room"),
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
      body: CarrelRoom(),
      drawer: SideDrawer(),
    );
  }
}
