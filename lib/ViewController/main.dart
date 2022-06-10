import 'package:flutter/material.dart';
import 'home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../firebase_options.dart';
import 'login.dart';

FocusNode myFocusNode = FocusNode();
Future<void> main() async {
  runApp(const MaterialApp(
    home: Home(),
  ));
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  static const String _title = 'Fitness Buddy';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: Login(),
    );
  }
}
