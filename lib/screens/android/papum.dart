import 'package:papum/screens/android/login.dart';
import 'package:flutter/material.dart';

class AppCovid extends StatelessWidget {
  const AppCovid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Login(),
    );
  }
}