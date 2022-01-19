import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:library_booking_system/Screens/Booking/booking.dart';
import 'package:library_booking_system/Screens/Meeting/meeting.dart';
import 'package:library_booking_system/Screens/Carrel/carrel.dart';
import 'package:library_booking_system/Screens/Carrel/updateCarrel.dart';
import 'package:library_booking_system/Screens/Meeting/updateMeeting.dart';

class BookingRecord extends StatefulWidget {
  @override
  _BookingRecordState createState() => _BookingRecordState();
}

class _BookingRecordState extends State<BookingRecord> {
  String dateCarrel, roomCarrel, timeCarrel;
  String dateMeeting, roomMeeting, timeMeeting;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(children: <Widget>[
      FutureBuilder(
          future: _fetchCarrel(),
          builder: (context, snapshot) {
            if (roomCarrel != null) {
              if (snapshot.connectionState != ConnectionState.done)
                return Center(
                  child: CircularProgressIndicator(),
                );
              return new Container(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: Colors.blueGrey[200],
                  //height: 40,
                  elevation: 10,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    //countDocuments(),
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.checklist_rtl, size: 60),
                        title: Text('Carrel Room',
                            style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                                fontSize: 18)),
                        subtitle: Text(
                            '\nRoom : $roomCarrel \nDate : $dateCarrel \nTime : $timeCarrel',
                            style:
                                TextStyle(color: Colors.black54, fontSize: 16)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 10.0, bottom: 10.0, left: 30.0, right: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            new Container(
                              height: 30,
                              width: 80,
                              decoration: BoxDecoration(
                                  color: Colors.redAccent,
                                  borderRadius: BorderRadius.circular(20)),
                              child: FlatButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text(
                                              'Delete Carrel Room Booking'),
                                          content: Text(
                                              'Are you sure you want delete the booking?'),
                                          actions: [
                                            FlatButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text('Cancel')),
                                            FlatButton(
                                                onPressed: () {
                                                  deleteCarrelRecord()
                                                      .whenComplete(
                                                          () => Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            Booking()),
                                                              ));
                                                },
                                                child: Text('Delete'))
                                          ],
                                        );
                                      });
                                },
                                child: Text(
                                  'Delete',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              ),
                            ),
                            new Container(
                              height: 30,
                              width: 80,
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(20)),
                              child: FlatButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => UpdateCarrel()),
                                  );
                                },
                                child: Text(
                                  'Update',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: Colors.blueGrey[200],
                //height: 40,
                elevation: 10,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.checklist_rtl, size: 60),
                      title: Text('Carrel Room',
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                              fontSize: 18)),
                      subtitle: Text('\nNo Booking for Carrel Room',
                          style:
                              TextStyle(color: Colors.black54, fontSize: 16)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 10.0, bottom: 10.0, left: 30.0, right: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          new Container(
                            height: 30,
                            width: 120,
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(20)),
                            child: FlatButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Carrel()),
                                );
                              },
                              child: Text(
                                'Book Now',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          }),
      FutureBuilder(
          future: _fetchMeeting(),
          builder: (context, snapshot) {
            if (roomMeeting != null) {
              return new Container(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: Colors.blueGrey[200],
                  //height: 40,
                  elevation: 10,

                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.checklist_rtl, size: 60),
                        title: Text('Meeting Room',
                            style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                                fontSize: 18)),
                        subtitle: Text(
                            '\nRoom : $roomMeeting \nDate : $dateMeeting \nTime : $timeMeeting',
                            style:
                                TextStyle(color: Colors.black54, fontSize: 16)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 10.0, bottom: 10.0, left: 30.0, right: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            new Container(
                              height: 30,
                              width: 80,
                              decoration: BoxDecoration(
                                  color: Colors.redAccent,
                                  borderRadius: BorderRadius.circular(20)),
                              child: FlatButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text(
                                              'Delete Meeting Room Booking'),
                                          content: Text(
                                              'Are you sure you want delete the booking?'),
                                          actions: [
                                            FlatButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text('Cancel')),
                                            FlatButton(
                                                onPressed: () {
                                                  deleteMeetingRecord()
                                                      .whenComplete(
                                                          () => Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            Booking()),
                                                              ));
                                                },
                                                child: Text('Delete'))
                                          ],
                                        );
                                      });
                                },
                                child: Text(
                                  'Delete',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              ),
                            ),
                            new Container(
                              height: 30,
                              width: 80,
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(20)),
                              child: FlatButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => UpdateMeeting()),
                                  );
                                },
                                child: Text(
                                  'Update',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: Colors.blueGrey[200],
                //height: 40,
                elevation: 10,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.checklist_rtl, size: 60),
                      title: Text('Meeting Room',
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                              fontSize: 18)),
                      subtitle: Text('\nNo Booking for Meeting Room',
                          style:
                              TextStyle(color: Colors.black54, fontSize: 16)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 10.0, bottom: 10.0, left: 30.0, right: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          new Container(
                            height: 30,
                            width: 120,
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(20)),
                            child: FlatButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Meeting()),
                                );
                              },
                              child: Text(
                                'Book Now',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          }),
    ]));
  }

  _fetchCarrel() async {
    final firebaseUser = await FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection('BookingCarrel')
          .doc(firebaseUser.uid)
          .get()
          .then((ds) {
        dateCarrel = ds.data()['selectedBookingdate'];
        roomCarrel = ds.data()['selectedRoom'];
        timeCarrel = ds.data()['selectedTimeSlot'];
        print(dateMeeting);
        print(roomMeeting);
        print(timeMeeting);
      }).catchError((e) {
        print(e);
      });
    } else {
      return print('No Booking Has Been Made');
    }
  }

  _fetchMeeting() async {
    final firebaseUser = await FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection('BookingMeeting')
          .doc(firebaseUser.uid)
          .get()
          .then((ds) {
        dateMeeting = ds.data()['selectedBookingdate'];
        roomMeeting = ds.data()['selectedRoom'];
        timeMeeting = ds.data()['selectedTimeSlot'];
        print(dateMeeting);
        print(roomMeeting);
        print(timeMeeting);
      }).catchError((e) {
        print(e);
      });
    } else {
      return print('No Booking Has Been Made');
      // dateMeeting = ds.data()['No data available'];
      // roomMeeting = ds.data()['No data available'];
      // timeMeeting = ds.data()['No data available'];
      // print(dateMeeting);
      // print(roomMeeting);
      // print(timeMeeting);
    }
  }

  deleteCarrelRecord() async {
    final firebaseUser = await FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection('BookingCarrel')
          .doc(firebaseUser.uid)
          .delete();
    } else {
      return print('failed to delete');
    }
  }

  deleteMeetingRecord() async {
    final firebaseUser = await FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection('BookingMeeting')
          .doc(firebaseUser.uid)
          .delete();
    } else {
      return print('failed to delete');
    }
  }
}
