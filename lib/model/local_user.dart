import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class localUser {
  String id;
  String profileImagePath;
  String coverImagePath;
  String name;
  String email;
  String? center;
  int amountOfPublicWorkouts;
  int amountOfFollowing;
  int amountOfFollowers;
  String? twitter;
  String? instagram;
  String? spotify;
  String? facebook;
  List<String> workoutIDs = [];

  localUser({
    required this.id,
    required this.name,
    required this.profileImagePath,
    required this.coverImagePath,
    required this.email,
    required this.amountOfPublicWorkouts,
    required this.amountOfFollowing,
    required this.amountOfFollowers,
    this.twitter,
    this.instagram,
    this.spotify,
    this.facebook,
    this.center,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'profileImagePath': profileImagePath,
        'coverImagePath': coverImagePath,
        'name': name,
        'email': email,
        'center': center,
        'amountOfPublicWorkouts': amountOfPublicWorkouts,
        'amountOfFollowing': amountOfFollowing,
        'amountOfFollowers': amountOfFollowers,
        'twitter': twitter,
        'instagram': instagram,
        'spotify': spotify,
        'facebook': facebook,
        "workoutIDs": workoutIDs,
      };

  static localUser fromJson(Map<String, dynamic> json) => localUser(
        id: json['id'],
        profileImagePath: json['profileImagePath'],
        coverImagePath: json['coverImagePath'],
        name: json['name'],
        email: json['email'],
        center: json['center'],
        amountOfPublicWorkouts: json['amountOfPublicWorkouts'],
        amountOfFollowing: json['amountOfFollowing'],
        amountOfFollowers: json['amountOfFollowers'],
        twitter: json['center'],
        instagram: json['center'],
        spotify: json['center'],
        facebook: json['center'],
      );

  void addWorkoutID(String id) {
    workoutIDs.add(id);
    FirebaseFirestore.instance.collection("users").doc(email).update({
      "workoutIDs": FieldValue.arrayUnion([id]),
    });
  }
}
