import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:library_booking_system/Screens/Booking/booking.dart';

class UpdateCarrelBooking extends StatefulWidget {
  @override
  _UpdateCarrelBookingState createState() => _UpdateCarrelBookingState();
}

class _UpdateCarrelBookingState extends State<UpdateCarrelBooking> {
  String dateCarrel, roomCarrel, timeCarrel;
  var selectedRoom, selectedBookingdate, selectedTimeSlot;
  final GlobalKey<FormState> _formKeyValue = new GlobalKey<FormState>();

  getSelectedRoom(selectedRoom) {
    this.selectedRoom = selectedRoom;
  }

  getSelectedBookingdate(selectedBookingdate) {
    this.selectedBookingdate = selectedBookingdate;
  }

  getSelectedTimeSlot(selectedTimeSlot) {
    this.selectedTimeSlot = selectedTimeSlot;
  }

  createdata() {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    DocumentReference bk = FirebaseFirestore.instance
        .collection('BookingCarrel')
        .doc(firebaseUser.uid);
    Map<String, dynamic> booking = {
      "selectedRoom": selectedRoom,
      "selectedBookingdate": selectedBookingdate,
      "selectedTimeSlot": selectedTimeSlot,
    };
    bk.set(booking).whenComplete(() {
      // print("Creating Room Booking Successfully");
      return showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text("Message"),
          content: Text("Room Booking Updated Successfully!"),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Booking()),
                );
              },
              child: Text("OK"),
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: _fetch(),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done)
                return Center(
                  child: CircularProgressIndicator(),
                );
              return Form(
                key: _formKeyValue,
                autovalidate: true,
                child: new ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  children: <Widget>[
                    new Container(
                      child: Column(
                        //countDocuments(),
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Center(
                              child: Container(
                                  width: 300,
                                  height: 250,
                                  child: Image.asset('Images/Carrel_2.png')),
                            ),
                          ),
                        ],
                      ),
                    ),
                    new Container(
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        color: Colors.blueGrey,
                        elevation: 10,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[],
                        ),
                      ),
                    ),
                    //Dynamic-Room
                    StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection("Carrel")
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            const Text("Loading.....");
                          } else {
                            List<DropdownMenuItem> carrel = [];
                            for (int i = 0;
                                i < snapshot.data.docs.length;
                                i++) {
                              DocumentSnapshot snap = snapshot.data.docs[i];
                              carrel.add(
                                DropdownMenuItem(
                                  child: Text(
                                    snap.id,
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                  value: "${snap.id}",
                                ),
                              );
                            }
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                new Container(
                                    padding: EdgeInsets.only(
                                        top: 30.0,
                                        bottom: 0.0,
                                        left: 30.0,
                                        right: 20.0),
                                    child: Text('Choose Room :',
                                        style: new TextStyle(
                                            fontSize: 17.0,
                                            fontWeight: FontWeight.bold))),
                                SizedBox(width: 10.0),
                                new Container(
                                    padding: EdgeInsets.only(
                                        top: 30.0,
                                        bottom: 0.0,
                                        left: 30.0,
                                        right: 20.0),
                                    child: DropdownButton(
                                      items: carrel,
                                      onChanged: (carrelroomvalue) {
                                        final snackBar = SnackBar(
                                          content: Text(
                                            'Selected room is $carrelroomvalue',
                                            style:
                                                TextStyle(color: Colors.blue),
                                          ),
                                        );
                                        Scaffold.of(context)
                                            .showSnackBar(snackBar);
                                        setState(() {
                                          selectedRoom = carrelroomvalue;
                                        });
                                      },
                                      value: selectedRoom,
                                      isExpanded: false,
                                      hint: new Text(
                                        '$roomCarrel',
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                    )),
                              ],
                            );
                          }
                          return Text("Done");
                        }),
                    //Dynamic Date
                    StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection("CarrelDate")
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            const Text("Loading.....");
                          } else {
                            List<DropdownMenuItem> carrelDate = [];
                            for (int i = 0;
                                i < snapshot.data.docs.length;
                                i++) {
                              DocumentSnapshot snap = snapshot.data.docs[i];
                              carrelDate.add(
                                DropdownMenuItem(
                                  child: Text(
                                    snap.id,
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                  value: "${snap.id}",
                                ),
                              );
                            }
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                new Container(
                                    padding: EdgeInsets.only(
                                        top: 10.0,
                                        bottom: 0.0,
                                        left: 30.0,
                                        right: 10.0),
                                    child: Text('Choose Date :',
                                        style: new TextStyle(
                                            fontSize: 17.0,
                                            fontWeight: FontWeight.bold))),
                                SizedBox(width: 50.0),
                                new Container(
                                    padding: EdgeInsets.only(
                                        top: 10.0,
                                        bottom: 0.0,
                                        left: 10.0,
                                        right: 10.0),
                                    child: DropdownButton(
                                      items: carrelDate,
                                      onChanged: (carrelDatevalue) {
                                        final snackBar = SnackBar(
                                          content: Text(
                                            'Selected date is $carrelDatevalue',
                                            style:
                                                TextStyle(color: Colors.blue),
                                          ),
                                        );
                                        Scaffold.of(context)
                                            .showSnackBar(snackBar);
                                        setState(() {
                                          selectedBookingdate = carrelDatevalue;
                                        });
                                      },
                                      value: selectedBookingdate,
                                      isExpanded: false,
                                      hint: new Text(
                                        '$dateCarrel',
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                    )),
                              ],
                            );
                          }
                          return Text("Done");
                        }),

                    //Dynamic Time
                    StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection("CarrelTime")
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            const Text("Loading.....");
                          } else {
                            List<DropdownMenuItem> CarrelTime = [];
                            for (int i = 0;
                                i < snapshot.data.docs.length;
                                i++) {
                              DocumentSnapshot snap = snapshot.data.docs[i];
                              CarrelTime.add(
                                DropdownMenuItem(
                                  child: Text(
                                    snap.id,
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                  value: "${snap.id}",
                                ),
                              );
                            }
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                new Container(
                                    padding: EdgeInsets.only(
                                        top: 10.0,
                                        bottom: 0.0,
                                        left: 30.0,
                                        right: 10.0),
                                    child: Text('Choose Time :',
                                        style: new TextStyle(
                                            fontSize: 17.0,
                                            fontWeight: FontWeight.bold)
                                        //   fontFamily: 'Roboto',
                                        //   color: new Color(0xFF26C6DA),
                                        )),
                                new Container(
                                    padding: EdgeInsets.only(
                                        top: 10.0,
                                        bottom: 0.0,
                                        left: 10.0,
                                        right: 10.0),
                                    child: DropdownButton(
                                      items: CarrelTime,
                                      onChanged: (carrelTimevalue) {
                                        final snackBar = SnackBar(
                                          content: Text(
                                            'Selected date is $carrelTimevalue',
                                            style:
                                                TextStyle(color: Colors.blue),
                                          ),
                                        );
                                        Scaffold.of(context)
                                            .showSnackBar(snackBar);
                                        setState(() {
                                          selectedTimeSlot = carrelTimevalue;
                                        });
                                      },
                                      value: selectedTimeSlot,
                                      isExpanded: false,
                                      hint: new Text(
                                        '$timeCarrel',
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                    )),
                              ],
                            );
                          }
                          return Text("Done");
                        }),
                    SizedBox(height: 50.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        new Container(
                          height: 40,
                          width: 140,
                          decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.circular(20)),
                          child: FlatButton(
                            onPressed: () {},
                            child: Text(
                              'Cancel',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                        SizedBox(width: 30),
                        new Container(
                          height: 40,
                          width: 140,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(20)),
                          child: FlatButton(
                            onPressed: () {
                              createdata();
                            },
                            child: Text(
                              'Update',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }));
  }

  _fetch() async {
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
        print(dateCarrel);
        print(roomCarrel);
        print(timeCarrel);
      }).catchError((e) {
        print(e);
      });
    } else {
      return print('No Booking Has Been Made');
    }
  }
}
