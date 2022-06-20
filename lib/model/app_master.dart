import 'package:fitness_body_app/model/rutine.dart';
import 'package:fitness_body_app/model/workout.dart';
import 'package:fitness_body_app/model/local_user.dart';

class Master {
  List<Workout> workouts = [];
  localUser currentUser;

  Master({required this.workouts, required this.currentUser}){}


  void newWorkout(Workout w) {
    w.isAdded = true;
    workouts.add(w);
    currentUser.addWorkoutID(w.id!);
  }

  void addWorkout(Workout w) {
    w.isAdded = false;
    workouts.add(w);
    currentUser.addWorkoutID(w.id!);
  }

  void deleteWorkout(int index) {
    workouts.remove(index);
  }
}
