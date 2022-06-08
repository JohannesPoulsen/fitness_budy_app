class Rutine{
  String? name;
  bool public = false;

  Rutine(String this.name, bool this.public);

  Rutine newRutine(String name, bool public){
    return Rutine(name, public);
  }
}