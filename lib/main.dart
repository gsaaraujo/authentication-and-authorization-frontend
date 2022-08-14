import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:authentication_and_authorization_frontend/app/app.dart';

void main() async {
  await Hive.initFlutter();

  runApp(const App());
}
