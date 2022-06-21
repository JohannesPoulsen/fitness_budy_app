import 'package:fitness_body_app/model/workout.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fitness_body_app/firebase_options.dart';
import 'package:fitness_body_app/view_controller/login.dart';

import 'services/firestore_download.dart';

FocusNode myFocusNode = FocusNode();
List<Workout> publicWorkouts = [];
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  publicWorkouts = await FirestoreDownload.getWorkouts();
  runApp(MaterialApp(
    initialRoute: '/',
    theme: ThemeData(
      primaryColor: Colors
          .lightGreen, //here it goes try changing this to your preferred colour
    ),
    routes: {
      '/': (context) => const Login(),
    },
  ));
}
