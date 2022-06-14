import 'package:fitness_body_app/Model/Rutine.dart';

class Workout{
  List<Rutine> workoutList = [];
  List<String> tags = [];
  String name;
  String? type;
  String? url;
  Workout({ required this.name }){}

  void set workoutType(String type){
    this.type = type;
  }
  String get workoutType{
    return this.type ?? '';
  }

  void set workoutName(String name){
    this.name = name;
  }
  String get workoutName{
    return this.name;
  }

  void set workoutUrl(String? url){
    this.url = url;
  }
  String get workoutUrl{
    return this.url ?? '';
  }

  void addWorkout(List<Rutine> workout){
    this.workoutList = workout;
  }

  void addTags(String tags){
    this.tags.add(tags);
  }

  Workout cloneWorkout(){
    Workout workout = Workout(name: '${this.name} copy');
    workout.url = this.url;
    addWorkout(this.workoutList);
    return workout;
  }
}