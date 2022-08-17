import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:authentication_and_authorization_frontend/src/main/app.dart';
import 'package:authentication_and_authorization_frontend/src/main/app_module.dart';

void main() async {
  await Hive.initFlutter();
  await dotenv.load(fileName: ".env");

  runApp(ModularApp(module: AppModule(), child: const App()));
}
