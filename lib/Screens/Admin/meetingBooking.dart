import 'package:flutter/material.dart';
import 'package:library_booking_system/Model/MeetingBooking.dart';
import 'package:library_booking_system/Screens/AuthScreen/login.dart';
import 'package:library_booking_system/Services/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:library_booking_system/Services/Database.dart';
import 'meetingBookingList.dart';

class MeetingBody extends StatefulWidget {
  @override
  _MeetingBodyState createState() => _MeetingBodyState();
}

class _MeetingBodyState extends State<MeetingBody> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<MeetingBooking>>.value(
        value: DatabaseService().meeting,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text('Field Booking'),
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
          body: MeetingList(),
        ));
  }
}
