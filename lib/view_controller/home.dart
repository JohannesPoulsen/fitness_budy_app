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

  List<Widget> widgetOptions = [];
  List<String> days = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];
  List<double> hours = [0, 0, 0, 0, 0, 0, 0];
  weekdays _dropdownvalue = weekdays.Monday;

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
            label: 'Workouts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Progress',
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
      if (hours[weekdays.values.indexOf(_dropdownvalue)] >= 3) return;
      hours[weekdays.values.indexOf(_dropdownvalue)] += 0.5;
    });
  }

  void _hourDecrease() {
    setState(() {
      if (hours[weekdays.values.indexOf(_dropdownvalue)] <= 0) return;
      hours[weekdays.values.indexOf(_dropdownvalue)] -= 0.5;
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
                        customItemsIndexes: (widget.master.currentUser.id == widget.master.workouts[index].userId) ? const [3] : const [1],
                        customItemsHeight: 8,
                        items: (widget.master.currentUser.id == widget.master.workouts[index].userId) ? [
                          ...MenuItems.secondItems.map(
                            (item) => DropdownMenuItem<MenuItem2>(
                              value: item,
                              child: MenuItems.buildItem(item),
                            ),
                          ),
                        ] : [
                          ...MenuItems.thirdItems.map(
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
                                Workout w = widget.master.workouts[index]
                                    .cloneWorkout();
                                FirestoreUpload.uploadPublicWorkout(w);
                                widget.master.newWorkout(w);
                              });
                              break;
                            case MenuItems.edit:
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CreateWorkout(
                                          master: widget.master,
                                          workout:
                                              widget.master.workouts[index],
                                        )),
                              );
                              FirestoreUpload.uploadPublicWorkout(widget.master.workouts[index]);
                              setState(() {});
                              break;
                            case MenuItems.delete:
                              break;
                          }
                        },
                        itemHeight: 48,
                        itemPadding: const EdgeInsets.only(left: 16, right: 16),
                        dropdownWidth: 160,
                        dropdownPadding:
                            const EdgeInsets.symmetric(vertical: 6),
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
                labelText: "Search",
                hintText: "Search",
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
                      icon: iconForSearchList(items[index]),
                      onPressed: () {
                        addWorkoutToWorkout(items[index]);
                      },
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
                  value: _dropdownvalue.weekdayToString(),
                  items: days.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _dropdownvalue = newValue!.toEnum(weekdays.values)!;
                    });
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Amount of hours trained ${_dropdownvalue.weekdayToString()}:',
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
                  hours[_dropdownvalue.index].toString(),
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
                'My week',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
              child: SizedBox(
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
                    maxY: 4,
                    lineBarsData: [
                      LineChartBarData(
                        spots: [
                          FlSpot(weekdays.Monday.index.toDouble(),
                              hours[weekdays.Monday.index]),
                          FlSpot(weekdays.Tuesday.index.toDouble(),
                              hours[weekdays.Tuesday.index]),
                          FlSpot(weekdays.Wednesday.index.toDouble(),
                              hours[weekdays.Wednesday.index]),
                          FlSpot(weekdays.Thursday.index.toDouble(),
                              hours[weekdays.Thursday.index]),
                          FlSpot(weekdays.Friday.index.toDouble(),
                              hours[weekdays.Friday.index]),
                          FlSpot(weekdays.Saturday.index.toDouble(),
                              hours[weekdays.Saturday.index]),
                          FlSpot(weekdays.Sunday.index.toDouble(),
                              hours[weekdays.Sunday.index]),
                        ],
                        isCurved: true,
                        colors: [
                          const Color(0xFF6fcd6b),
                          const Color(0xFF6fcd6b),
                        ],
                        barWidth: 10,
                      ),
                    ],
                  ),
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

  Widget iconForSearchList(workout) {
    if (widget.master.workouts.contains(workout)) {
      return const Icon(Icons.check);
    }
    return const Icon(Icons.add);
  }

  void addWorkoutToWorkout(workout) {
    if (!widget.master.workouts.contains(workout)) {
      setState(() {
        widget.master.addWorkout(workout);
        workout.isAdded = true;
      });
    }
  }

  void filterSearchResults(String query) {
    List<Workout> dummySearchList = <Workout>[];
    dummySearchList.addAll(duplicateItems);
    if (query.isNotEmpty) {
      List<Workout> dummyListData = <Workout>[];
      for (var item in dummySearchList) {
        if (item.name.contains(query) || item.tags!.contains(query)) {
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

enum weekdays {
  Monday,
  Tuesday,
  Wednesday,
  Thursday,
  Friday,
  Saturday,
  Sunday,
}

extension ParseToString on weekdays {
  String weekdayToString() {
    return toString().split('.').last;
  }
}

extension EnumParser on String {
  T toEnum<T>(List<T> values) {
    return values.firstWhere((e) =>
        e.toString().toLowerCase().split(".").last == '$this'.toLowerCase());
  }
}
