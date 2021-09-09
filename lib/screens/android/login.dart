import 'package:papum/database/freteiroDAO.dart';
import 'package:flutter/material.dart';

import 'dashboard.dart';

class Login extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Tela de Login'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 300.0),
        width: double.infinity,
        height: 80,
        child: RaisedButton(
          onPressed: (){

            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => Dashboard()
            ));

          },
          elevation: 10.0,
          color: Colors.deepPurple,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30)
          ),
          padding: EdgeInsets.all(20),
          child: Text('LOGIN', style: TextStyle(
              color: Colors.white,
              letterSpacing: 1.5,
              fontSize: 10.0,
              fontWeight: FontWeight.bold
          ),),
        ),
      ),
    );
  }
}
