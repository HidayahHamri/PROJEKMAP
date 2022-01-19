import 'package:flutter/material.dart';
import 'package:library_booking_system/Screens/Admin/carrelBookingList.dart';
import 'package:library_booking_system/Screens/AuthScreen/login.dart';
import 'package:library_booking_system/Services/auth_provider.dart';
import 'package:library_booking_system/Model/CarrelBooking.dart';
import 'package:provider/provider.dart';
import 'package:library_booking_system/Services/Database.dart';

class CarrelBody extends StatefulWidget {
  @override
  _CarrelBodyState createState() => _CarrelBodyState();
}

class _CarrelBodyState extends State<CarrelBody> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<CarrelBooking>>.value(
        value: DatabaseService().carrel,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text('Sport Hall Booking'),
            backgroundColor: Colors.blue,
            actions: <Widget>[
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
          body: CarrelList(),
        ));
  }
}
