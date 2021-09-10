import 'dart:io';
import 'package:papum/database/freteiroDAO.dart';
import 'package:papum/screens/android/papum.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'model/freteiro.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  if(Platform.isAndroid){
    debugPrint('app no android');
    runApp(papum());
  }
  if(Platform.isIOS){
    debugPrint('app no ios');
  }

}
