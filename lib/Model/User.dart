import 'package:uuid/uuid.dart';

class localUser {
  String id;
  String? profileImagePath;
  String? coverImagePath;
  String name;
  String email;
  int amountOfPublicWorkouts;
  int amountOfFollowing;
  int amountOfFollowers;

  localUser(
      {required this.name,
      required this.email,
      required this.id,
      required this.amountOfPublicWorkouts,
      required this.amountOfFollowing,
      required this.amountOfFollowers}) {}
}
