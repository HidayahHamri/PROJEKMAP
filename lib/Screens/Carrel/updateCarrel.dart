import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:library_booking_system/Screens/Carrel/updateCarrel_body.dart';
import 'package:library_booking_system/Services/auth_provider.dart';
import 'package:library_booking_system/Screens/AuthScreen/login.dart';
import 'package:library_booking_system/Screens/drawer.dart';

class UpdateCarrel extends StatefulWidget {
  @override
  _UpdateCarrelState createState() => _UpdateCarrelState();
}

class _UpdateCarrelState extends State<UpdateCarrel> {
  String user = FirebaseAuth.instance.currentUser.email == null
      ? FirebaseAuth.instance.currentUser.phoneNumber
      : FirebaseAuth.instance.currentUser.email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Carrel Room Booking"),
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
      body: UpdateCarrelBooking(),
      drawer: SideDrawer(),
    );
  }
}
