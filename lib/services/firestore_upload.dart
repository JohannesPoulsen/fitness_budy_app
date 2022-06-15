

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_body_app/Model/Workout.dart';
import 'package:fitness_body_app/Model/localUser.dart';

class FirestoreUpload {
  

  static Future uploadUser(localUser user) async {
    final firestoreDocument = FirebaseFirestore.instance.collection("users").doc(user.email);

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

  static Future uploadWorkout(Workout workout) async {
    final firestoreDocument = FirebaseFirestore.instance.collection("workouts").doc(workout.name);

    final dataForUpload = {
      "name": workout.name
      // TODO: create map for workout parameters
    };

    await firestoreDocument.set(dataForUpload);

  }


}