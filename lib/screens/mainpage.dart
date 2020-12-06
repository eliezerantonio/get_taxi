import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  static const String id="mainpage";
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
      ),
      body: Center(
        child: MaterialButton(
          height: 44,
          textColor: Colors.white,
          child: Text("Test connection"),
          minWidth: 300,
          color: Colors.grey,
          onPressed:test,
        ),
      ),
    );
  }

  void test(){
    DatabaseReference dbRef =
    FirebaseDatabase.instance.reference().child("Test");
    dbRef.set('isConnected');
  }
}
