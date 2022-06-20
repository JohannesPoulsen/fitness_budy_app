import 'package:fitness_body_app/model/rutine.dart';
import 'package:fitness_body_app/model/workout.dart';
import 'package:fitness_body_app/model/local_user.dart';

class Master {
  List<Rutine> rutines = [];
  List<Workout> workouts = [];
  localUser currentUser;

  Master(this.rutines, this.workouts, this.currentUser);

  void newRutine(Rutine r) {
    rutines.add(r);
  }

  void newWorkout(Workout w) {
    w.isAdded = true;
    workouts.add(w);
    currentUser.addWorkoutID(w.id!);
  }

  void deleteRutine(int index) {
    rutines.remove(index);
  }

  void deleteWorkout(int index) {
    workouts.remove(index);
  }
}
