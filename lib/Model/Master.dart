import 'package:fitness_body_app/Model/Rutine.dart';
import 'package:fitness_body_app/Model/Workout.dart';

class Master{
  List<Rutine> rutines = [];
  List<Workout> workouts = [];

  Master(this.rutines, this.workouts);

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