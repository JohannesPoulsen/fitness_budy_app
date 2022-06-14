import 'package:flutter/material.dart';
import 'package:fitness_body_app/Model/Master.dart';
import 'package:fitness_body_app/Model/Workout.dart';

class Add_rutine extends StatefulWidget {
  const Add_rutine({Key? key, required this.master, required this.workout}) : super(key: key);

  final Master master;
  final Workout workout;

  @override
  _Add_rutineState createState() => _Add_rutineState();
}

class _Add_rutineState extends State<Add_rutine> {
  var rutines = <String>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Rutines'),
        backgroundColor: Colors.black,
      ),
      body: ListView.builder(
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
        onPressed: () {
          addItem("hej");
        },
        backgroundColor: const Color.fromARGB(255, 190, 24, 12),
        // icon: const Icon(
        //   Icons.add,
        // ),
      );
    } else {
      return FloatingActionButton(
        onPressed: () {
          addItem("hej");
        },
        backgroundColor: const Color.fromARGB(255, 190, 24, 12),
        child: const Icon(
          Icons.add,
        ),
      );
    }
  }
}
