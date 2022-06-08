import 'Rutine.dart';
class Strength extends Rutine{
  int? repitions;
  int? duration;

  Strength(String name, bool public, int this.repitions, int this.duration) : super(name, public);

  Strength newCardio(String name, bool public, int repitions, int duration) {
    return Strength(name, public, repitions, duration);

  }
}