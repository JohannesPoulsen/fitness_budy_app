import 'package:uuid/uuid.dart';

class User {
  String id;
  String? profileImagePath;
  String? coverImagePath;
  String name;
  String email;
  int amountOfPublicWorkouts;
  int amountOfFollowing;
  int amountOfFollowers;

  User(
      {required this.name,
      required this.email,
      required this.id,
      required this.amountOfPublicWorkouts,
      required this.amountOfFollowing,
      required this.amountOfFollowers}) {}
}
