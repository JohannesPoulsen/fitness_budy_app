import 'package:uuid/uuid.dart';

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

  localUser({
    required this.name,
    required this.profileImagePath,
    required this.coverImagePath,
    required this.email,
    required this.id,
    required this.amountOfPublicWorkouts,
    required this.amountOfFollowing,
    required this.amountOfFollowers,
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
      );
}
