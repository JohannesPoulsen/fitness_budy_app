import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_body_app/Model/OtherRutine.dart';
import 'package:fitness_body_app/Model/Rutine.dart';
import 'package:fitness_body_app/Model/Strength.dart';
import 'package:fitness_body_app/Model/Workout.dart';
import 'package:fitness_body_app/model/local_user.dart';
import '../Model/Cardio.dart';

class FirestoreDownload {
  static Workout downloadWorkout() {
    var workout = Workout(name: "name");
    return workout;
  }
}
