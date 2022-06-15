import 'package:fitness_body_app/Model/Cardio.dart';
import 'package:fitness_body_app/Model/Strength.dart';
import 'package:flutter/material.dart';
import 'package:fitness_body_app/Model/Master.dart';
import 'package:fitness_body_app/Model/Workout.dart';
import 'package:fitness_body_app/ViewController/create_rutine.dart';
import 'package:fitness_body_app/ViewController/home.dart';
import 'package:fitness_body_app/Model/Rutine.dart';

class Add_rutine extends StatefulWidget {
  final Master master;
  final Workout workout;
  const Add_rutine({Key? key, required this.master, required this.workout})
      : super(key: key);

  @override
  _AddRutineState createState() => _AddRutineState();
}

class _AddRutineState extends State<Add_rutine> {
  var rutines = <String>[];
  var listOfRutines = <Rutine>[];
  @override
  void initState() {
    super.initState();
    listOfRutines = widget.workout.workoutList;
    for (int i = 0; i < listOfRutines.length; i++) {
      rutines.add(listOfRutines[i].name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Rutines'),
        backgroundColor: Colors.black,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                if (widget.workout.isAdded) {
                  widget.workout.addWorkout(listOfRutines);
                } else {
                  widget.workout.addWorkout(listOfRutines);
                  widget.master.newWorkout(widget.workout);
                }
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomeScreen(master: widget.master)),
                );
              },
              child: const Icon(
                Icons.save,
                size: 26.0,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Text(
            widget.workout.workoutName,
            style: const TextStyle(
              fontSize: 30,
            ),
          ),
          ReorderableListView.builder(
            shrinkWrap: true,
            itemCount: rutines.length,
            itemBuilder: (context, index) {
              return Card(
                key: Key('$index'),
                color: tileColorInList(listOfRutines[index]),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.black, width: 0.5),
                      borderRadius: BorderRadius.circular(10)),
                  title: Text(rutines[index]),
                  subtitle: subTitle(listOfRutines[index]),
                ),
              );
            },
            onReorder: (int oldIndex, int newIndex) {
              setState(() {
                if (oldIndex < newIndex) {
                  newIndex -= 1;
                }
                final String item = rutines.removeAt(oldIndex);
                final Rutine item2 = listOfRutines.removeAt(oldIndex);
                rutines.insert(newIndex, item);
                listOfRutines.insert(newIndex, item2);
              });
            },
          ),
        ],
      ),
      floatingActionButton: addKnap(),
    );
  }

  Color tileColorInList(rutineString) {
    if (rutineString is Cardio) {
      return Colors.lightBlue;
    } else if (rutineString is Strength) {
      return Colors.red;
    } else {
      return const Color(0xFF6fcd6b);
    }
  }

  Widget subTitle(rutine) {
    if (rutine is Cardio) {
      return Text(
          "Distance: ${rutine.distance} - Duration: ${rutine.duration}");
    } else if (rutine is Strength) {
      return Text(
          "Repititions: ${rutine.repetitions} - Duration: ${rutine.duration}");
    } else {
      return Text(
          "Repititions: ${rutine.repetition} - Duration: ${rutine.duration} - Distance: ${rutine.distance}");
    }
  }

  Widget addKnap() {
    if (rutines.length < 6) {
      return FloatingActionButton.extended(
        label: const Text("Add Rutine"),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CreateRutine(master: widget.master)),
          );
          if (result != null) {
            setState(() {
              rutines.add(result.name);
              listOfRutines.add(result);
            });
          }
        },
        backgroundColor: const Color.fromARGB(255, 190, 24, 12),
      );
    } else {
      return FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CreateRutine(master: widget.master)),
          );
          if (result != null) {
            setState(() {
              rutines.add(result.name);
            });
          }
        },
        backgroundColor: const Color.fromARGB(255, 190, 24, 12),
        child: const Icon(
          Icons.add,
        ),
      );
    }
  }

  void initRutinesList() {
    setState(() {
      for (Rutine r in widget.workout.workoutList) {
        rutines.add(r.name);
      }
    });
  }
}
