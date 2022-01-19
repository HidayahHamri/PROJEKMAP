import 'package:flutter/material.dart';
import 'package:library_booking_system/Screens/Booking/booking.dart';
import 'package:library_booking_system/Screens/Homepage/home.dart';
import 'UserProfile/profile.dart';

//import '../Login/login_screen.dart';

class SideDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(
            child: Center(
              child: Text(
                'Library Booking \n System',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          Card(
            child: ListTile(
                leading: Icon(Icons.home),
                title: Text('Dashboard'),
                onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      ),
                    }),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.article_outlined),
              title: Text('Booking Record'),
              onTap: () => {
                Navigator.push(
                  context,
                  //MaterialPageRoute(builder: (context) => BookingHistory()),
                  MaterialPageRoute(builder: (context) => Booking()),
                ),
              },
            ),
          ),
          Card(
            child: ListTile(
                leading: Icon(Icons.assignment_ind_outlined),
                title: Text('View Profile'),
                onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Profile()),
                      ),
                    }),
          ),
        ],
      ),
    );
  }
}
