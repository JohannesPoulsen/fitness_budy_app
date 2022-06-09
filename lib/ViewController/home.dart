import 'package:flutter/material.dart';
import '../Model/Master.dart';
import 'create_workout.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String searchString = "";
  int _selectedIndex = 0;
  static Master master = Master([], []);

  List<Widget> widgetOptions = [];

  @override
  void initState() {
    super.initState();
    widgetOptions = listOfWidgets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fitness Buddy"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_run),
            label: 'Træninger',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined),
            label: 'Søg',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Udvikling',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.red,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onSearch(String value) {
    setState(() {
      searchString = value.toLowerCase();
    });
  }

  List<Widget> listOfWidgets() {
    return (<Widget>[
      Column(
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateWorkout(master: master)),
              );
            },
            backgroundColor: Colors.red,
            child: const Icon(
              Icons.add,
            ),
          ),
        ],
      ),
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              onChanged: (value) {
                _onSearch(value);
              },
              decoration: const InputDecoration(
                labelText: ('Søg...'),
                labelStyle: (TextStyle(color: Colors.red)),
                suffixIcon: Icon(
                  Icons.search,
                  color: Colors.red,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 0.5),
                ),
              ),
              cursorColor: Colors.red,
            ),
          ),
        ],
      ),
      Column(),
    ]);
  }
}