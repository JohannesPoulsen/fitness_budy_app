import 'package:fitness_body_app/model/workout.dart';
import 'package:fitness_body_app/model/local_user.dart';

class Master {
  List<Workout> workouts = [];
  LocalUser currentUser;

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

  bool containsWorkout(Workout w){
    for (int i = 0; i< workouts.length; i++){
      if (workouts[i].id == w.id){
        return true;
      }
    }
    return false;
  }
}
