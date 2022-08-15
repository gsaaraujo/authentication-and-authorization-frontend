import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:authentication_and_authorization_frontend/src/main/app.dart';

void main() async {
  await Hive.initFlutter();
  await dotenv.load(fileName: ".env");

  runApp(const App());
}
