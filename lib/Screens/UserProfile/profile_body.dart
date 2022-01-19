import 'package:flutter/material.dart';
//import 'package:library_booking_system/Services/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileBody extends StatefulWidget {
  @override
  _ProfileBodyState createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  String fullname, email, contact;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: FutureBuilder(
        //future: _fetch(),
        builder: (context, snapshot) {
      if (snapshot.connectionState != ConnectionState.done)
        return Center(
          child: CircularProgressIndicator(),
        );
      return SafeArea(
          child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 60.0),
            child: Center(
              child: Container(
                  width: 500,
                  height: 150,
                  child: Image.asset('Images/Profile.png')),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(
                  left: 60.0, right: 60.0, top: 70, bottom: 0),
              child: Center(
                child: TextFormField(
                  enabled: false,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Fullname",
                      labelStyle:
                          TextStyle(color: Colors.blueGrey, fontSize: 22)),
                ),
              )),
          Padding(
              padding: const EdgeInsets.only(
                  left: 60.0, right: 60.0, top: 30, bottom: 0),
              child: Center(
                child: TextFormField(
                  enabled: false,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Email",
                      labelStyle:
                          TextStyle(color: Colors.blueGrey, fontSize: 22)),
                ),
              )),
          Padding(
              padding: const EdgeInsets.only(
                  left: 60.0, right: 60.0, top: 30, bottom: 0),
              child: Center(
                child: TextFormField(
                  enabled: false,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Contact",
                      labelStyle:
                          TextStyle(color: Colors.blueGrey, fontSize: 22)),
                ),
              )),
        ],
      ));
    }));
  }
}
