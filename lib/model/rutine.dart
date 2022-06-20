class Rutine {
  String name;
  String? url;
  bool isAdded = false;

  Rutine({required this.name, this.url});

  Rutine newRutine(String name, bool public) {
    return Rutine(name: name, public: public);
  }
  Added(){
    isAdded = true;
  }
}
