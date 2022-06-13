import 'package:fitness_body_app/Model/Rutine.dart';
class Strength extends Rutine{
  int? repitions;
  int? duration;

  Strength({ name, public, url, this.repitions, this.duration}) : super(name: name, public: public, url: url);

  Strength newCardio(String name, bool public, String? url, int? repitions, int? duration) {
    return Strength(name: name, public: public, repitions: repitions, duration: duration, url: url);

  }
}