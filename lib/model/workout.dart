import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_body_app/model/cardio.dart';
import 'package:fitness_body_app/model/other_rutine.dart';
import 'package:fitness_body_app/model/rutine.dart';
import 'package:fitness_body_app/model/strength.dart';
import 'package:flutter/material.dart';

class Workout {
  List<Rutine> workoutList = [];
  String? tags;
  String name;
  final String? userId = FirebaseAuth.instance.currentUser?.uid;
  String? _workoutID;
  String? type;
  String? url;
  bool public = false;
  bool isAdded = false;
  Workout({required this.name}) {
    this._workoutID = '${this.userId} ${this.name}';
  }

  String? get workoutID {
    return this._workoutID;
  }

  void set workoutType(String type) {
    this.type = type;
  }

  String get workoutType {
    return this.type ?? '';
  }

  String? get id {
    return _workoutID;
  }

  void set workoutName(String name) {
    this.name = name;
  }

  String get workoutName {
    return this.name;
  }

  void set workoutUrl(String? url) {
    this.url = url;
  }

  String get workoutUrl {
    return this.url ?? '';
  }

  void addWorkout(List<Rutine> workout) {
    this.workoutList = workout;
  }

  void set Tags(String tags) {
    this.tags = tags;
  }

  void set workoutID(String? workoutID) {
    this._workoutID = workoutID;
  }

  Workout cloneWorkout() {
    Workout workout = Workout(name: '${this.name} copy');
    workout.url = this.url;
    workout.Tags = this.tags ?? '';
    workout.workoutType = this.type ?? '';
    workout.public = this.public;
    List<Rutine> l = [];
    for (var i = 0; i < workoutList.length; i++){
      if (workoutList[i] is Cardio){
        Cardio r = workoutList[i] as Cardio;
        Cardio c = Cardio(name: r.name, distance:  r.distance, url: r.url, duration: r.duration);
        l.add(c);
      }
      else if (workoutList[i] is Strength){
        Strength r = workoutList[i] as Strength;
        Strength c = Strength(name: r.name, repetitions: r.repetitions , url: r.url, sets: r.sets);
        l.add(c);
      }
      else if (workoutList[i] is OtherRutine){
        OtherRutine r = workoutList[i] as OtherRutine;
        OtherRutine c = OtherRutine(name: r.name, repetitions: r.repetitions , url: r.url, distance: r.distance, duration: r.duration);
        l.add(c);
      }
    }
    workout.addWorkout(l);
    return workout;
  }

  static Workout fromJson(Map<String, dynamic> json) {
    var workout = Workout(name: json["name"]);
    workout.type = json["type"];
    workout._workoutID = json["workoutID"];
    workout.tags = json["tags"];
    return workout;
  }

  static Widget buildWorkout(Workout workout) => ListTile(
        title: Text(workout.name),
        subtitle: Text(workout.type!),
      );
}
