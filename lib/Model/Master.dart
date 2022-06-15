import 'package:fitness_body_app/Model/Rutine.dart';
import 'package:fitness_body_app/Model/Workout.dart';
import 'package:fitness_body_app/Model/localUser.dart';

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
  }

  void deleteRutine(int index) {
    rutines.remove(index);
  }

  void deleteWorkout(int index) {
    workouts.remove(index);
  }
}
