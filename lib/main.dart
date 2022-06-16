import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fitness_body_app/firebase_options.dart';
import 'package:fitness_body_app/view_controller/login.dart';

FocusNode myFocusNode = FocusNode();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MaterialApp(
    initialRoute: '/',
    theme: ThemeData(
      primaryColor: Colors.lightGreen,//here it goes try changing this to your preferred colour
    ),
    routes: {
      '/': (context) => const Login(),
    },
  ));
}
