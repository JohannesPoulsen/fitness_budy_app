import 'package:flutter/material.dart';
import 'package:fitness_body_app/Model/Master.dart';
import 'package:fitness_body_app/ViewController/create_workout.dart';
import 'package:fitness_body_app/ViewController/profile.dart';
import 'package:fl_chart/fl_chart.dart';
import '../Model/lineTitles.dart';

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
        selectedItemColor: const Color.fromARGB(255, 190, 24, 12),
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
          backgroundColor: const Color.fromARGB(255, 190, 24, 12),
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
              cursorColor: const Color.fromARGB(255, 190, 24, 12),
              decoration: const InputDecoration(
                labelText: "Søg",
                hintText: "Søg",
                labelStyle:
                    (TextStyle(color: Color.fromARGB(255, 190, 24, 12))),
                prefixIcon: Icon(
                  Icons.search,
                  color: Color.fromARGB(255, 190, 24, 12),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  borderSide: BorderSide(
                      width: 3, color: Color.fromARGB(255, 190, 24, 12)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  borderSide: BorderSide(
                      width: 3, color: Color.fromARGB(255, 190, 24, 12)),
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
      children:[
        const Text(
              'Statistik',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
        Container(
            width: 1000,
            height: 600,
            color: Colors.white,
            child: LineChart(  
          LineChartData(
            gridData: FlGridData(show: false),
            borderData: FlBorderData(show:false),
            titlesData: LineTitles.getTitleData(),
            minX: 0,
            maxX: 14,
            minY: 0,
            maxY: 8,
            lineBarsData: [
              LineChartBarData(
                spots: [
                  const FlSpot(0, 2.5),
                  const FlSpot(2, 2),
                  const FlSpot(4, 3),
                  const FlSpot(6, 2.5),
                  const FlSpot(8, 2),
                  const FlSpot(10, 4),
                  const FlSpot(12, 2.5),
                  const FlSpot(14, 1.5),
                ],
                isCurved: true,
                colors: [Colors.red,Colors.red],
                barWidth: 5,
                dotData: FlDotData(
                  show: true,
                
                ),
              ),
            ],
          ),
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
          Text(
            widget.master.currentUser.name,
            style: const TextStyle(
              color: Color.fromARGB(255, 190, 24, 12),
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
          Text(
            widget.master.currentUser.center ?? '',
            style: const TextStyle(
              color: Color.fromARGB(255, 190, 24, 12),
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
              color: Color.fromARGB(255, 190, 24, 12),
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
                widget.master.currentUser.email,
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
              backgroundColor: const Color.fromARGB(255, 190, 24, 12),
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
