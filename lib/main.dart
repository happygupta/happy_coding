import 'package:first_app/login.dart';
import 'package:flutter/material.dart';


void main() => runApp(app());

class app extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "First-App",
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        //primaryColor: Colors.blue
      ),
      home: Login(),
    );
  }
}
