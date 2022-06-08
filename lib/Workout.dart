import 'Rutine.dart';

class Workout{
  List<Rutine> workout = [];

  void set name(String name){
    this.name = name;
  }

  void addWorkout(List<Rutine> workout){
    this.workout = workout;
  }

}