import 'package:flutter/material.dart';
import 'package:fitness_body_app/Model/Master.dart';
import 'package:fitness_body_app/ViewController/create_workout.dart';
import 'package:fitness_body_app/ViewController/profile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.master}) : super(key: key);

  final Master master;
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController editingController = TextEditingController();
  final duplicateItems = List<String>.generate(10000, (i) => "Item $i");
  var items = <String>[];

  String searchString = "";
  int _selectedIndex = 0;

  List<Widget> widgetOptions = [];

  @override
  void initState() {
    super.initState();
    items.addAll(duplicateItems);
    widgetOptions = listOfWidgets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Fitness Buddy"),
          centerTitle: true,
          backgroundColor: Colors.black,
          actions: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ProfileScreen(master: widget.master)),
                );
              },
              icon: const Icon(Icons.person),
              tooltip: "Profile",
            ),
          ]),
      body: Center(
        child: listOfWidgets().elementAt(_selectedIndex),
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

  List<Widget> listOfWidgets() {
    return (<Widget>[
      Scaffold(
        body: Center(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(items[index]),
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CreateWorkout(master: widget.master)),
            );
          },
          backgroundColor: Colors.red,
          child: const Icon(
            Icons.add,
          ),
        ),
      ),
      Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                filterSearchResults(value);
              },
              controller: editingController,
              cursorColor: Colors.red,
              decoration: const InputDecoration(
                labelText: "Søg",
                hintText: "Søg",
                labelStyle: (TextStyle(color: Colors.red)),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.red,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  borderSide: BorderSide(width: 3, color: Colors.red),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  borderSide: BorderSide(width: 3, color: Colors.red),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(items[index]),
                  trailing: const Icon(
                    Icons.fitness_center,
                  ),
                  onTap: () {},
                );
              },
            ),
          ),
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Center(
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://previews.123rf.com/images/jemastock/jemastock1708/jemastock170807787/83959218-muscular-man-flexing-biceps-avatar-fitness-icon-image-vector-illustration-design.jpg'),
              radius: 40.0,
            ),
          ),
          Divider(
            color: Colors.grey[600],
            height: 60.0,
          ),
          const Text(
            'Navn',
            style: TextStyle(
              color: Colors.grey,
              letterSpacing: 2.0,
            ),
          ),
          const SizedBox(height: 10.0),
          const Text(
            'Søren Sveder',
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: 28.0,
              letterSpacing: 2.0,
            ),
          ),
          const SizedBox(height: 30.0),
          const Text(
            'Center',
            style: TextStyle(
              color: Colors.grey,
              letterSpacing: 2.0,
            ),
          ),
          const SizedBox(height: 10.0),
          const Text(
            'Hornbæk Fitness, Danmark',
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: 28.0,
              letterSpacing: 2.0,
            ),
          ),
          const SizedBox(height: 30.0),
          const Text(
            'Timer trænet i denne måned',
            style: TextStyle(
              color: Colors.grey,
              letterSpacing: 2.0,
            ),
          ),
          const SizedBox(height: 10.0),
          const Text(
            '5',
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: 28.0,
              letterSpacing: 2.0,
            ),
          ),
          const SizedBox(height: 30.0),
          Row(
            children: <Widget>[
              Icon(
                Icons.email,
                color: Colors.grey[600],
              ),
              const SizedBox(width: 10.0),
              Text(
                'søren.jegsveder@gmail.com',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 18.0,
                  letterSpacing: 1.0,
                ),
              )
            ],
          ),
          const SizedBox(height: 30.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Min uge',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 18.0,
                  letterSpacing: 1.0,
                ),
              )
            ],
          ),
          Align(
            alignment: Alignment.topRight,
            child: FloatingActionButton(
              hoverColor: Colors.orange,
              onPressed: () {},
              backgroundColor: Colors.red,
              child: const Icon(Icons.more_horiz),
            ),
          ),
        ],
      ),
    ]);
  }

  void filterSearchResults(String query) {
    List<String> dummySearchList = <String>[];
    dummySearchList.addAll(duplicateItems);
    if (query.isNotEmpty) {
      List<String> dummyListData = <String>[];
      for (var item in dummySearchList) {
        if (item.contains(query)) {
          dummyListData.add(item);
        }
      }
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(duplicateItems);
      });
    }
  }
}
