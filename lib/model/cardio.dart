import 'package:fitness_body_app/model/rutine.dart';

class Cardio extends Rutine {
  int? distance;
  int? duration;

  Cardio({name, public, url, this.distance, this.duration})
      : super(name: name, public: public, url: url);

  Cardio newCardio(
      String name, bool public, String? url, int? distance, int? duration) {
    return Cardio(
        name: name,
        public: public,
        url: url,
        distance: distance,
        duration: duration);
  }

  static Rutine fromJson(Map<String, dynamic> json) => Cardio(
        name: json["name"],
        public: json["public"],
        //url: json["url"],
        distance: json["distance"],
        duration: json["duration"],
      );
}
