import 'package:fitness_body_app/Model/Rutine.dart';

class Workout{
  List<Rutine> workoutList = [];

  void set name(String name){
    this.name = name;
  }
  String get name{
    return this.name;
  }

  void set url(String? url){
    this.url = url;
  }
  String get url{
    return this.url;
  }

  void addWorkout(List<Rutine> workout){
    this.workoutList = workout;
  }

  Workout cloneWorkout(){
    Workout workout = Workout();
    workout.name = '${this.name} copy';
    workout.url = this.url;
    addWorkout(this.workoutList);
    return workout;
  }
}