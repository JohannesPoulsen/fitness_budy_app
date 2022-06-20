import 'package:fitness_body_app/main.dart';
import 'package:fitness_body_app/model/workout.dart';
import 'package:fitness_body_app/view_controller/add_rutine.dart';
import 'package:flutter/material.dart';
import 'package:fitness_body_app/model/app_master.dart';
import 'package:fitness_body_app/view_controller/create_workout.dart';
import 'package:fitness_body_app/view_controller/profile.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:fitness_body_app/widgets/line_titles.dart';
import 'package:fitness_body_app/services/firestore_download.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fitness_body_app/widgets/menu_items.dart';
import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:fitness_body_app/services/firestore_upload.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.master}) : super(key: key);

  final Master master;
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List? workouts;
  TextEditingController editingController = TextEditingController();
  final duplicateItems = publicWorkouts;
  var items = <Workout>[];

  String searchString = "";
  int _selectedIndex = 0;
  double _counter = 0;

  List<Widget> widgetOptions = [];
  List<String> days = [
    'Mandag',
    'Tirsdag',
    'Onsdag',
    'Torsdag',
    'Fredag',
    'Lørdag',
    'Søndag'
  ];
  List<double> hours = [];
  String _dropdownvalue = 'Mandag';

  @override
  void initState() {
    super.initState();
    items.addAll(duplicateItems!);
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

  void _hourIncrease() {
    setState(() {
      _counter += 0.5;
      if (_counter >= 2) {
        _counter = 2;
      }
    });
  }

  void _hourDecrease() {
    setState(() {
      _counter -= 0.5;
      if (_counter <= 0) {
        _counter = 0;
      }
    });
  }

  Color tileColorInList(workoutType) {
    if (workoutType == "Cardio") {
      return Colors.lightBlue;
    } else if (workoutType == "Strength") {
      return Colors.red;
    } else {
      return const Color(0xFF6fcd6b);
    }
  }

  List<Widget> listOfWidgets() {
    return (<Widget>[
      Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              ReorderableListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.master.workouts.length,
                itemBuilder: (context, index) {
                  return Card(
                    key: Key('$index'),
                    color: tileColorInList(widget.master.workouts[index].type),
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Add_rutine(
                                master: widget.master,
                                workout: widget.master.workouts[index]),
                          ),
                        );
                      },
                      title: Text(widget.master.workouts[index].workoutName),
                      subtitle: tagTitle(widget.master.workouts[index]),
                      trailing: DropdownButton2(
                        customButton: const Icon(
                          Icons.more_vert,
                        ),
                        customItemsIndexes: const [2],
                        customItemsHeight: 8,
                        items: [
                          ...MenuItems.secondItems.map(
                                (item) => DropdownMenuItem<MenuItem2>(
                              value: item,
                              child: MenuItems.buildItem(item),
                            ),
                          ),
                        ],
                        onChanged: (value) async {
                          switch (value) {
                            case MenuItems.clone:
                              setState(() {
                                Workout w = widget.master.workouts[index].cloneWorkout();
                                FirestoreUpload.uploadPublicWorkout(w);
                                widget.master.newWorkout(w);
                              });
                              break;
                            case MenuItems.edit:
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CreateWorkout(master: widget.master, workout: widget.master.workouts[index],)),
                              );
                              FirestoreUpload.uploadPublicWorkout(widget.master.workouts[index]);
                              setState(() {});
                              break;
                          }
                        },
                        itemHeight: 48,
                        itemPadding: const EdgeInsets.only(left: 16, right: 16),
                        dropdownWidth: 160,
                        dropdownPadding: const EdgeInsets.symmetric(vertical: 6),
                        dropdownDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        dropdownElevation: 8,
                        offset: const Offset(0, 8),
                      ),
                    ),
                  );
                },
                onReorder: (int oldIndex, int newIndex) {
                  setState(() {
                    if (oldIndex < newIndex) {
                      newIndex -= 1;
                    }
                    final Workout item =
                        widget.master.workouts.removeAt(oldIndex);
                    widget.master.workouts.insert(newIndex, item);
                  });
                },
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CreateWorkout(master: widget.master)),
            );
            setState(() {});
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
                return Card(
                  color: tileColorInList(items[index].type),
                  key: Key('$index'),
                  child: ListTile(
                    trailing: IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {},
                    ),
                    onTap: () {},
                    title: Text(items[index].name),
                    subtitle: tagTitle(items[index]),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // const Center(
            //   child: CircleAvatar(
            //     backgroundImage: NetworkImage(
            //         'https://previews.123rf.com/images/jemastock/jemastock1708/jemastock170807787/83959218-muscular-man-flexing-biceps-avatar-fitness-icon-image-vector-illustration-design.jpg'),
            //     radius: 40.0,
            //   ),
            // ),
            // Divider(
            //   color: Colors.grey[600],
            //   height: 60.0,
            // ),
            Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.topRight,
                  child: FloatingActionButton(
                    heroTag: 'fl1',
                    hoverColor: Colors.orange,
                    onPressed: _hourIncrease,
                    backgroundColor: const Color(0xFF6fcd6b),
                    child: const Icon(Icons.add),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: FloatingActionButton(
                    heroTag: 'fl2',
                    hoverColor: Colors.orange,
                    onPressed: _hourDecrease,
                    backgroundColor: const Color(0xFF6fcd6b),
                    child: const Icon(Icons.remove),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                DropdownButton<String>(
                  value: _dropdownvalue,
                  items: days.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _dropdownvalue = newValue!;
                    });
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Antal timer trænet $_dropdownvalue',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 18.0,
                    letterSpacing: 1.0,
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  '$_counter',
                  style: const TextStyle(
                    color: Color(0xFF6fcd6b),
                    fontSize: 24.0,
                    letterSpacing: 1.0,
                  ),
                )
              ],
            ),
            const SizedBox(
              width: 50,
              height: 10,
            ),
            const Center(
              child: Text(
                'Min uge',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              width: 400,
              height: 400,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  titlesData: LineTitles.getTitleData(),
                  minX: 0,
                  maxX: 8,
                  minY: 0,
                  maxY: 3,
                  lineBarsData: [
                    if (_dropdownvalue == 'Mandag')
                      LineChartBarData(
                        spots: [
                          FlSpot(1, _counter),
                          const FlSpot(2, 0),
                          const FlSpot(3, 0),
                          const FlSpot(4, 0),
                          const FlSpot(5, 0),
                          const FlSpot(6, 0),
                          const FlSpot(7, 0),
                        ],
                        isCurved: true,
                        colors: [
                          const Color(0xFF6fcd6b),
                          const Color(0xFF6fcd6b)
                        ],
                        barWidth: 10,
                      ),
                    if (_dropdownvalue == 'Tirsdag')
                      LineChartBarData(
                        spots: [
                          const FlSpot(1, 2),
                          FlSpot(2, _counter),
                          const FlSpot(3, 0),
                          const FlSpot(4, 0),
                          const FlSpot(5, 0),
                          const FlSpot(6, 0),
                          const FlSpot(7, 0),
                        ],
                        isCurved: true,
                        colors: [
                          const Color(0xFF6fcd6b),
                          const Color(0xFF6fcd6b)
                        ],
                        barWidth: 10,
                      ),
                    if (_dropdownvalue == 'Onsdag')
                      LineChartBarData(
                        spots: [
                          const FlSpot(1, 2),
                          const FlSpot(2, 2),
                          FlSpot(3, _counter),
                          const FlSpot(4, 0),
                          const FlSpot(5, 0),
                          const FlSpot(6, 0),
                          const FlSpot(7, 0),
                        ],
                        isCurved: true,
                        colors: [
                          const Color(0xFF6fcd6b),
                          const Color(0xFF6fcd6b)
                        ],
                        barWidth: 10,
                      ),
                    if (_dropdownvalue == 'Torsdag')
                      LineChartBarData(
                        spots: [
                          const FlSpot(1, 2),
                          const FlSpot(2, 2),
                          const FlSpot(3, 2),
                          FlSpot(4, _counter),
                          const FlSpot(5, 0),
                          const FlSpot(6, 0),
                          const FlSpot(7, 0),
                        ],
                        isCurved: true,
                        colors: [
                          const Color(0xFF6fcd6b),
                          const Color(0xFF6fcd6b)
                        ],
                        barWidth: 10,
                      ),
                    if (_dropdownvalue == 'Fredag')
                      LineChartBarData(
                        spots: [
                          const FlSpot(1, 2),
                          const FlSpot(2, 2),
                          const FlSpot(3, 2),
                          const FlSpot(4, 2),
                          FlSpot(5, _counter),
                          const FlSpot(6, 0),
                          const FlSpot(7, 0),
                        ],
                        isCurved: true,
                        colors: [
                          const Color(0xFF6fcd6b),
                          const Color(0xFF6fcd6b)
                        ],
                        barWidth: 10,
                      ),
                    if (_dropdownvalue == 'Lørdag')
                      LineChartBarData(
                        spots: [
                          const FlSpot(1, 2),
                          const FlSpot(2, 2),
                          const FlSpot(3, 2),
                          const FlSpot(4, 2),
                          const FlSpot(5, 2),
                          FlSpot(6, _counter),
                          const FlSpot(7, 0),
                        ],
                        isCurved: true,
                        colors: [
                          const Color(0xFF6fcd6b),
                          const Color(0xFF6fcd6b)
                        ],
                        barWidth: 10,
                      ),
                    if (_dropdownvalue == 'Søndag')
                      LineChartBarData(
                        spots: [
                          const FlSpot(1, 2),
                          const FlSpot(2, 2),
                          const FlSpot(3, 2),
                          const FlSpot(4, 2),
                          const FlSpot(5, 2),
                          const FlSpot(6, 2),
                          FlSpot(7, _counter),
                        ],
                        isCurved: true,
                        colors: [
                          const Color(0xFF6fcd6b),
                          const Color(0xFF6fcd6b)
                        ],
                        barWidth: 10,
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ]);
  }

  Widget tagTitle(workout) {
    return Text(workout.tags);
  }

  void filterSearchResults(String query) {
    List<Workout> dummySearchList = <Workout>[];
    dummySearchList.addAll(duplicateItems!);
    if (query.isNotEmpty) {
      List<Workout> dummyListData = <Workout>[];
      for (var item in dummySearchList) {
        if (item.name.contains(query)) {
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
        items.addAll(duplicateItems!);
      });
    }
  }
}


