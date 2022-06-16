import 'package:fitness_body_app/Model/Rutine.dart';

class OtherRutine extends Rutine {
  int? distance;
  int? duration;
  int? repetitions;

  OtherRutine(
      {name, public, url, this.distance, this.duration, this.repetitions})
      : super(name: name, public: public, url: url);

  OtherRutine newOtherRutine(String name, bool public, String? url,
      int? distance, int? duration, int? repetition) {
    return OtherRutine(
        name: name,
        public: public,
        url: url,
        distance: distance,
        duration: duration,
        repetitions: repetition);
  }
}
