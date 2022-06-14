import 'package:flutter/material.dart';
import 'package:fitness_body_app/Model/Master.dart';
import 'package:fitness_body_app/Model/Workout.dart';
import 'create_rutine.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Rutines'),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Text(
            widget.workout.workoutName,
            style: const TextStyle(
              fontSize: 30,
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: rutines.length,
            itemBuilder: (context, index) {
              return ListTile(
                shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.black, width: 0.5),
                    borderRadius: BorderRadius.circular(10)),
                title: Text(rutines[index]),
                subtitle: Text("Reps: "),
              );
            },
          ),
        ],
      ),
      floatingActionButton: addKnap(),
    );
  }

  void addItem(text) {
    setState(() {
      rutines.add(text);
    });
  }

  Widget addKnap() {
    if (rutines.length < 6) {
      return FloatingActionButton.extended(
        label: const Text("Add Rutine"),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateRutine()),
          );
          if (result != null) {
            setState(() {
              addItem(result.name);
            });
          }
        },
        backgroundColor: const Color.fromARGB(255, 190, 24, 12),
        // icon: const Icon(
        //   Icons.add,
        // ),
      );
    } else {
      return FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateRutine()),
          );
          if (result != null) {
            setState(() {
              addItem(result.name);
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
