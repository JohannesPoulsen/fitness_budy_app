import 'package:fitness_body_app/model/rutine.dart';

class Cardio extends Rutine {
  int? distance;
  int? duration;

  Cardio({name, url, this.distance, this.duration})
      : super(name: name, url: url);

  Cardio newCardio(
      String name, String? url, int? distance, int? duration) {
    return Cardio(
        name: name,
        url: url,
        distance: distance,
        duration: duration);
  }

  static Rutine fromJson(Map<String, dynamic> json) => Cardio(
        name: json["name"],
        //url: json["url"],
        distance: json["distance"],
        duration: json["duration"],
      );
}
