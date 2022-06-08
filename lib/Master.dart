import 'Rutine.dart';
import 'Workout.dart';

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
}