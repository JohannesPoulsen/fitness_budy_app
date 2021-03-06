import 'package:flutter/material.dart';
import 'package:fitness_body_app/model/workout.dart';
import 'package:fitness_body_app/model/app_master.dart';
import 'package:fitness_body_app/view_controller/add_rutine.dart';
import 'package:fitness_body_app/widgets/error_box.dart';

class CreateWorkout extends StatefulWidget {
  const CreateWorkout({Key? key, required this.master, this.workout})
      : super(key: key);

  final Master master;
  final Workout? workout;

  @override
  State<CreateWorkout> createState() => _CreateWorkoutState();
}

class _CreateWorkoutState extends State<CreateWorkout> {
  String workoutName = "";

  String typeValue = "Cardio";
  var options = [
    'Cardio',
    'Strength',
    'Mix',
  ];

  String tagName = "";

  bool public = false;

  @override
  void initState() {
    super.initState();
    if (widget.workout != null) {
      workoutName = widget.workout!.name;
      typeValue = widget.workout!.type!;
      public = widget.workout!.public;
      tagName = widget.workout!.tags!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Workout'),
        backgroundColor: Colors.black,
      ),
   body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(
            height: 25,
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(8, 0, 8, 4),
            child: Text("Workout: "),
          ),
          textFieldWidget("Enter workout name...", "workoutName", workoutName),
          const SizedBox(
            height: 25,
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(8, 0, 8, 4),
            child: Text("Type: "),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: DropdownButton(
              isExpanded: true,
              value: typeValue,
              icon: const Icon(Icons.arrow_drop_down_circle),
              items: options.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  typeValue = newValue!;
                });
              },
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(8, 0, 8, 4),
            child: Text("Tags: "),
          ),
          textFieldWidget("Add tags...", "tagName", tagName),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              const Text("Do you want the workout to be public? "),
              Checkbox(
                value: public,
                onChanged: (bool? value) {
                  setState(() {
                    public = value!;
                  });
                },
              ),
            ],
          ),
          Container(
            width: double.infinity,
            height: 40,
            alignment: Alignment.center,
            child: SizedBox(
              width: 250,
              height: 100,
              child: ElevatedButton(
                onPressed: () async {
                  if (workoutName.isNotEmpty) {
                    if (widget.workout != null) {
                      widget.workout!.workoutName = workoutName;
                      widget.workout!.workoutType = typeValue;
                      widget.workout!.tags = tagName;
                      Navigator.pop(context);
                    } else {
                      Workout workout = Workout(name: workoutName);

                      workout.tags = tagName;
                      workout.workoutType = typeValue;
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Add_rutine(
                              master: widget.master, workout: workout),
                        ),
                      );

                      if (result != null) {
                        widget.master.newWorkout(result);
                      }
                    }
                  } else {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return const ErrorBox(
                              errorName: 'Unnamed parameter.',
                              errorReason:
                                  'Give your workout a name, before continuing.');
                        });
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
    ),
    );
  }

  Widget textFieldWidget(tekst, content, initial) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: TextField(
        controller: TextEditingController()..text = '$initial',
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
      workoutName = value;
    } else {
      tagName = value;
    }
  }
}
