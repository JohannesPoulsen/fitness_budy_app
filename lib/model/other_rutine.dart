import 'package:fitness_body_app/model/rutine.dart';

class OtherRutine extends Rutine {
  int? distance;
  int? duration;
  int? repetitions;

  OtherRutine(
      {name, public, url, this.distance, this.duration, this.repetitions})
      : super(name: name, public: public, url: url);

  OtherRutine newOtherRutine(String name, bool public, String? url,
      int? distance, int? duration, int? repetitions) {
    return OtherRutine(
        name: name,
        public: public,
        url: url,
        distance: distance,
        duration: duration,
        repetitions: repetitions);
  }

  static Rutine fromJson(Map<String, dynamic> json) => OtherRutine(
      name: json["name"],
      public: json["public"],
      //url: json["url"],
      distance: json["distance"],
      duration: json["duration"],
      repetitions: json["repetition"]);
}
