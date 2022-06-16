import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_body_app/Model/Rutine.dart';
import 'package:fitness_body_app/services/authentication.dart';

class Workout{
  List<Rutine> workoutList = [];
  List<String> tags = [];
  String name;
  final String? userId = FirebaseAuth.instance.currentUser?.uid;
  String? _workoutID;
  String? type;
  String? url;
  bool isAdded = false;
  Workout({ required this.name }){
    this._workoutID = '${this.userId} ${this.name}';
  }

  void set workoutType(String type){
    this.type = type;
  }
  String get workoutType{
    return this.type ?? '';
  }

  String? get id{
    return _workoutID;
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