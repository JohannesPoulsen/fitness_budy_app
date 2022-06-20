import 'package:fitness_body_app/model/rutine.dart';

class Strength extends Rutine {
  int? repetitions;
  int? sets;

  Strength({name, url, this.repetitions, this.sets})
      : super(name: name, url: url);

  Strength newStrength(
      String name, String? url, int? repetitions, int? sets) {
    return Strength(
        name: name,
        repetitions: repetitions,
        sets: sets,
        url: url);
  }

  static Rutine fromJson(Map<String, dynamic> json) => Strength(
        name: json["name"],
        repetitions: json["repetitions"],
        sets: json["duration"],
      );
}
