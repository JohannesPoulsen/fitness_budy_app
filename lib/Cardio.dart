import 'Rutine.dart';

class Cardio extends Rutine{
  int? distance;
  int? duration;

  Cardio(String name, bool public, int this.distance, int this.duration) : super(name, public);

  Cardio newCardio(String name, bool public, int distance, int duration) {
    return Cardio(name, public, distance, duration);

  }
}