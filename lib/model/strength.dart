import 'package:fitness_body_app/model/rutine.dart';

class Strength extends Rutine {
  int? repetitions;
  int? sets;

  Strength({name, public, url, this.repetitions, this.sets})
      : super(name: name, public: public, url: url);

  Strength newStrength(
      String name, bool public, String? url, int? repetitions, int? sets) {
    return Strength(
        name: name,
        public: public,
        repetitions: repetitions,
        sets: sets,
        url: url);
  }

  static Rutine fromJson(Map<String, dynamic> json) => Strength(
        name: json["name"],
        public: json["public"],
        repetitions: json["repetitions"],
        sets: json["duration"],
      );
}
