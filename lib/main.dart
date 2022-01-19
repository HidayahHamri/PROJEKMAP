import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:library_booking_system/Model/Users.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  runApp(App());
}

// class App extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return StreamProvider<List<Users>>(
//      // value: AuthClass().user,
//       initialData: <Users>[],
//       child: MaterialApp(
//         home: Home(),
//       ),
//     );
//   }
// }

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Users>.value(
      initialData: Users(),
      child: MaterialApp(
        theme: ThemeData(backgroundColor: Colors.lightBlue),
        home: Home(),
      ),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {}
}
