import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_body_app/Model/OtherRutine.dart';
import 'package:fitness_body_app/Model/Rutine.dart';
import 'package:fitness_body_app/Model/Strength.dart';
import 'package:fitness_body_app/Model/Workout.dart';
import 'package:fitness_body_app/Model/localUser.dart';

import '../Model/Cardio.dart';

class FirestoreUpload {
  static Future uploadUser(localUser user) async {
    final firestoreDocument =
        FirebaseFirestore.instance.collection("users").doc(user.email);

    final dataForUpload = user.toJson();
    // TODO: remove below
    // final dataForUpload = {
    //   "id": user.id,
    //   "email": user.email,
    //   "name": user.name,
    //   "amountOfPublicWorkouts": user.amountOfPublicWorkouts,
    //   "amountOfFollowing": user.amountOfFollowing,
    //   "amountOfFollowers": user.amountOfFollowers,
    // };

    await firestoreDocument.set(dataForUpload);
  }

  static Future uploadPublicWorkout(Workout workout) async {
    //Upload workout document:
    final firestoreWorkoutDocument = FirebaseFirestore.instance
        .collection("publicWorkouts")
        .doc(workout.name);
    final workoutForUpload = {
      "name": workout.name,
      "type": workout.type,
      "tags": workout.tags,
    };
    await firestoreWorkoutDocument.set(workoutForUpload);

    //Upload rutines to the workout document:
    for (Rutine rutine in workout.workoutList) {
      final firestoreRutineDocument = FirebaseFirestore.instance
          .collection("publicWorkouts")
          .doc(workout.name)
          .collection("rutines")
          .doc(rutine.name);

      if (rutine is Strength) {
        final rutineForUpload = {
          "name": rutine.name,
          "repetitions": rutine.repetitions,
          "duration": rutine.duration,
        };
        await firestoreRutineDocument.set(rutineForUpload);
      } else if (rutine is Cardio) {
        final rutineForUpload = {
          "name": rutine.name,
          "distance": rutine.distance,
          "duration": rutine.duration,
        };
        await firestoreRutineDocument.set(rutineForUpload);
      } else if (rutine is OtherRutine) {
        final rutineForUpload = {
          "name": rutine.name,
          "repetitions": rutine.repetitions,
          "distance": rutine.distance,
          "duration": rutine.duration,
        };
        await firestoreRutineDocument.set(rutineForUpload);
      }
    }
  }
}
