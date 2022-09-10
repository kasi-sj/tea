import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/welcome.dart';
import 'screens/login.dart';
import 'screens/Register.dart';
import 'screens/people.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Welcome.id,
      routes: {
        Welcome.id: (context) => Welcome(),
        Login.id: (context) => Login(),
        Register.id: ((context) => Register()),
      },
    );
  }
}
