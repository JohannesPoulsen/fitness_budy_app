import 'package:fitness_body_app/model/rutine.dart';

class OtherRutine extends Rutine {
  int? distance;
  int? duration;
  int? repetitions;

  OtherRutine(
      {name, url, this.distance, this.duration, this.repetitions})
      : super(name: name, url: url);

  OtherRutine newOtherRutine(String name, String? url,
      int? distance, int? duration, int? repetitions) {
    return OtherRutine(
        name: name,
        url: url,
        distance: distance,
        duration: duration,
        repetitions: repetitions);
  }

  static Rutine fromJson(Map<String, dynamic> json) => OtherRutine(
      name: json["name"],
      //url: json["url"],
      distance: json["distance"],
      duration: json["duration"],
      repetitions: json["repetition"]);
}
