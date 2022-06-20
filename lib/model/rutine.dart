class Rutine {
  String name;
  String? url;

  Rutine({required this.name, this.url});

  Rutine newRutine(String name) {
    return Rutine(name: name);
  }
}
