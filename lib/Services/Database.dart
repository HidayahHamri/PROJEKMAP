import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:library_booking_system/Model/MeetingBooking.dart';
import 'package:library_booking_system/Model/Users.dart';
import 'package:library_booking_system/Model/Profile.dart';
import 'package:library_booking_system/Model/CarrelBooking.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  List<UserData> users = [];
  //final CollectionReference user = Firestore.instance.collection("User");
  final CollectionReference userProfile =
      FirebaseFirestore.instance.collection('Users');

  final CollectionReference carrelList =
      FirebaseFirestore.instance.collection('Carrel');

  final CollectionReference carrelHistory =
      FirebaseFirestore.instance.collection('BookingCarrel');

  final CollectionReference meetingHistory =
      FirebaseFirestore.instance.collection('BookingMeeting');

  Future updateUserData(
      String fullname, String username, String contact) async {
    return await userProfile.doc(uid).set({
      'fullname': fullname,
      'username': username,
      'contact': contact,
    });
  }

  List<Profile> _profileListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Profile(
          username: doc.data()['username'] ?? '',
          fullname: doc.data()['fullname'] ?? '',
          contact: doc.data()['contact'] ?? '');
    }).toList();
  }

  // userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        fullname: snapshot.data()['fullname'],
        username: snapshot.data()['username'],
        contact: snapshot.data()['contact']);
  }

  Stream<List<Profile>> get profile {
    return userProfile.snapshots().map(_profileListFromSnapshot);
  }

  // get carrel booking list
  List<CarrelBooking> _carrelListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return CarrelBooking(
          selectedRoom: doc.data()['selectedRoom'] ?? '',
          selectedBookingdate: doc.data()['selectedBookingdate'] ?? '',
          selectedTimeSlot: doc.data()['selectedTimeSlot'] ?? '');
    }).toList();
  }

  Stream<List<CarrelBooking>> get carrel {
    return carrelHistory.snapshots().map(_carrelListFromSnapshot);
  }

  //get meeting booking list
  List<MeetingBooking> _meetingListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return MeetingBooking(
          selectedRoom: doc.data()['selectedRoom'] ?? '',
          selectedBookingdate: doc.data()['selectedBookingdate'] ?? '',
          selectedTimeSlot: doc.data()['selectedTimeSlot'] ?? '');
    }).toList();
  }

  Stream<List<MeetingBooking>> get meeting {
    return meetingHistory.snapshots().map(_meetingListFromSnapshot);
  }

  Future<DocumentSnapshot> getUserData() async {
    final DocumentSnapshot doc = await userProfile.doc(uid).get();
    return doc;
  }

  Future<String> getCarrelCount() async {
    var length = 0;
    await FirebaseFirestore.instance
        .collection('Carrel')
        .get()
        .then((myDocuments) {
      print("${myDocuments.docs.length}");
      length = myDocuments.docs.length;
    });
    return Future.value(length.toString());
  }
}
