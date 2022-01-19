//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:library_booking_system/Screens/Admin/carrelBookingTile.dart';
import 'package:provider/provider.dart';
import 'package:library_booking_system/Model/CarrelBooking.dart';
//import 'package:library_booking_system/Carrel/carrel_tile.dart';

class CarrelList extends StatefulWidget {
  @override
  _CarrelListState createState() => _CarrelListState();
}

class _CarrelListState extends State<CarrelList> {
  @override
  Widget build(BuildContext context) {
    final carrels = Provider.of<List<CarrelBooking>>(context);
    if (carrels == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return ListView.builder(
        itemCount: carrels.length,
        itemBuilder: (context, index) {
          return CarrelTile(carrel: carrels[index]);
        },
      );
    }
  }
}
