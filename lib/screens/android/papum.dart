import 'package:papum/screens/android/login.dart';
import 'package:flutter/material.dart';

class papum extends StatelessWidget {
  const papum({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Login(),
    );
  }
}