import 'package:fitness_body_app/Model/Rutine.dart';
import 'package:fitness_body_app/Model/Workout.dart';
import 'package:fitness_body_app/Model/User.dart';

class Master{
  List<Rutine> rutines = [];
  List<Workout> workouts = [];
  User currentUser;

  Master(this.rutines, this.workouts, this.currentUser);

  void newRutine(Rutine r){
    rutines.add(r);
  }

  void newWorkout(Workout w){
    workouts.add(w);
  }

  void deleteRutine(int index){
    rutines.remove(index);
  }

  void deleteWorkout(int index){
    workouts.remove(index);
  }
}