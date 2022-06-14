import 'package:flutter/material.dart';
import 'package:fitness_body_app/Model/Workout.dart';
import 'package:fitness_body_app/Model/Cardio.dart';
import 'package:fitness_body_app/Model/Rutine.dart';
import 'package:fitness_body_app/Model/Master.dart';
import 'package:fitness_body_app/ViewController/add_rutine.dart';
import 'package:fitness_body_app/ViewController/errorBox.dart';

class CreateWorkout extends StatefulWidget {
  const CreateWorkout({Key? key, required this.master}) : super(key: key);

  final Master master;

  @override
  State<CreateWorkout> createState() => _CreateWorkoutState();
}

class _CreateWorkoutState extends State<CreateWorkout> {
  @override
  void initState() {
    super.initState();
  }

  String workoutName = "";

  String typeName = "";

  String tagName = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Workout'),
        backgroundColor: Colors.black,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(
            height: 25,
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(8, 0, 8, 4),
            child: Text("Workout: "),
          ),
          textFieldWidget("Enter workout name...", "workoutName"),
          const SizedBox(
            height: 25,
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(8, 0, 8, 4),
            child: Text("Type: "),
          ),
          textFieldWidget("Enter type...", "typeName"),
          const SizedBox(
            height: 25,
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(8, 0, 8, 4),
            child: Text("Tags: "),
          ),
          textFieldWidget("Add tags...", "tagName"),
          const SizedBox(
            height: 25,
          ),
          Container(
            width: double.infinity,
            height: 40,
            alignment: Alignment.center,
            child: SizedBox(
              width: 250,
              height: 100,
              child: ElevatedButton(
                onPressed: () {
                  if (workoutName.isNotEmpty){
                    Workout workout = Workout(name: workoutName);
                    workout.addTags(tagName);
                    workout.workoutType = typeName;
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Add_rutine(master: widget.master, workout: workout),
                      ),
                    );
                  }
                  else{
                    showDialog(
                        context: context,
                        builder: (context){
                          return const ErrorBox(errorName: 'Unnamed parameter.', errorReason: 'Give your workout a name, before continuing.');
                        }
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: const Color.fromARGB(255, 190, 24, 12),
                ),
                child: const Text("Create Workout",
                    style: TextStyle(fontSize: 20)),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget textFieldWidget(tekst, content) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: TextField(
        cursorColor: Colors.grey,
        onChanged: (value) {
          saveTextValue(content, value);
        },
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
          labelText: tekst,
          labelStyle: (const TextStyle(color: Colors.grey, fontSize: 15)),
          filled: true,
          fillColor: const Color(0xFFE0E0E0),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.grey),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.grey),
          ),
        ),
      ),
    );
  }

  void saveTextValue(content, value) {
    if (content == "workoutName") {
      setState(() {
        workoutName = value;
      });
    } else if (content == "typeName") {
      setState(() {
        typeName = value;
      });
    } else {
      setState(() {
        tagName = value;
      });
    }
  }
}
