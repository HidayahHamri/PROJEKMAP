class Users {
  String uid;
  Users({this.uid});
}

class UserData {
  final String uid;
  final String fullname;
  final String username;
  final String contact;
  final String email;

  UserData({this.uid, this.fullname, this.username, this.contact, this.email});

  factory UserData.fromDatabase(Map<String, dynamic> data) {
    return UserData(
        uid: data['uid'],
        fullname: data['fullname'],
        username: data['username'],
        contact: data['contact'],
        email: data['email']);
  }

  Map<String, dynamic> toDatabase() {
    return {
      'uid': uid,
      'fullname': fullname,
      'username': username,
      'contact': contact,
      'email': email
    };
  }

  String getUid() {
    return uid;
  }

  String getUsername() {
    return username;
  }
}
