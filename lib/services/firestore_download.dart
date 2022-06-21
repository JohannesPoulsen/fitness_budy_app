import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fitness_body_app/model/workout.dart';
import 'package:fitness_body_app/model/cardio.dart';
import 'package:fitness_body_app/model/other_rutine.dart';
import 'package:fitness_body_app/model/rutine.dart';
import 'package:fitness_body_app/model/strength.dart';

class FirestoreDownload {
  static List<String> workoutIDList = [];

  static Workout downloadWorkout() {
    var workout = Workout(name: "name");
    return workout;
  }

  static Stream<List<Workout>>? readWorkouts() => FirebaseFirestore.instance
      .collection("publicWorkouts")
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Workout.fromJson(doc.data())).toList());

  static Future<List<Workout>> getWorkouts() async {
    List<Workout> workoutList = [];
    var workoutsFromFirebase =
        await FirebaseFirestore.instance.collection("publicWorkouts").get();

    if (workoutsFromFirebase.docs.isNotEmpty) {
      for (var doc in workoutsFromFirebase.docs) {
        String name = doc.data()["name"];
        workoutIDList.add(doc.id);
        var workout = Workout(name: name);
        workout.workoutID = doc.id;
        workout.workoutList = await getRutines(doc.id);
        workout.type = doc.data()["type"];
        workout.tags = doc.data()["tags"];
        workout.userId = doc.data()["user"];
        workoutList.add(workout);
      }
    }
    return workoutList;
  }

  static Future<List<Rutine>> getRutines(workoutID) async {
    await Firebase.initializeApp();
    List<Rutine> rutines = [];
    var cardioCollection = await FirebaseFirestore.instance
        .collection("publicWorkouts")
        .doc(workoutID)
        .collection("cardio")
        .get();
    var strengthCollection = await FirebaseFirestore.instance
        .collection("publicWorkouts")
        .doc(workoutID)
        .collection("strength")
        .get();
    var otherCollection = await FirebaseFirestore.instance
        .collection("publicWorkouts")
        .doc(workoutID)
        .collection("other")
        .get();

    for (var cardioDoc in cardioCollection.docs) {
      var cardio = Cardio(
        name: cardioDoc.data()["name"],
      );
      cardio.distance = cardioDoc.data()["distance"];
      cardio.duration = cardioDoc.data()["duration"];
      rutines.add(cardio);
    }
    for (var strengthDoc in strengthCollection.docs) {
      var strength = Strength(
        name: strengthDoc.data()["name"],
      );
      strength.sets = strengthDoc.data()["sets"];
      strength.repetitions = strengthDoc.data()["repetitions"];
      rutines.add(strength);
    }
    for (var otherDoc in otherCollection.docs) {
      var other = OtherRutine(
        name: otherDoc.data()["name"],
      );
      other.duration = otherDoc.data()["duration"];
      other.repetitions = otherDoc.data()["repetitions"];
      other.distance = otherDoc.data()["distance"];
      rutines.add(other);
    }

    return rutines;
  }
}
