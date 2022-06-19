import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_body_app/model/workout.dart';

class FirestoreDownload {
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
        print(doc.data());
        var workout = Workout(name: name);
        workout.type = doc.data()["type"];
        workoutList.add(workout);
      }
    }
    return workoutList;
  }
}
