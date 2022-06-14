import 'package:fitness_body_app/Model/Rutine.dart';
class Strength extends Rutine{
  int? repetitions;
  int? duration;

  Strength({ name, public, url, this.repetitions, this.duration}) : super(name: name, public: public, url: url);

  Strength newCardio(String name, bool public, String? url, int? repitions, int? duration) {
    return Strength(name: name, public: public, repetitions: repitions, duration: duration, url: url);

  }
}