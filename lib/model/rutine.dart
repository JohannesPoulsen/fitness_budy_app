class Rutine {
  String name;
  bool public = false;
  String? url;
  bool isAdded = false;

  Rutine({required this.name, required this.public, this.url});

  Rutine newRutine(String name, bool public) {
    return Rutine(name: name, public: public);
  }
  Added(){
    isAdded = true;
  }
}
