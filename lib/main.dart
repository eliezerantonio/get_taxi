import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gettaxi/screens/login_page.dart';
import 'package:gettaxi/screens/main_page.dart';
import 'package:gettaxi/screens/register_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final FirebaseApp app = await FirebaseApp.configure(
    name: "db2",
    options: Platform.isIOS || Platform.isMacOS
        ? const FirebaseOptions(
            googleAppID: "1:768230283735:android:984e5f6b1243c857869392",
            gcmSenderID: "AIzaSyB_ndbdDcp4zJqOIDA4xf0L71kRGIsHdOQ",
            databaseURL: "https://gettaxi-661b5-default-rtdb.firebaseio.com",
          )
        : const FirebaseOptions(
            googleAppID: "1:768230283735:android:984e5f6b1243c857869392",
            apiKey: "AIzaSyB_ndbdDcp4zJqOIDA4xf0L71kRGIsHdOQ",
            databaseURL: "https://gettaxi-661b5-default-rtdb.firebaseio.com",
          ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Brand-Regular', primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,

      initialRoute: MainPage.id,
      routes: {
        RegisterPage.id: (context) => RegisterPage(),
        LoginPage.id: (context) => LoginPage(),
        MainPage.id: (context) => MainPage()
      },
    );
  }
}
