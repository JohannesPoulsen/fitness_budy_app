import 'package:flutter/material.dart';
import '../Model/Workout.dart';
import '../Model/Cardio.dart';
import '../Model/Rutine.dart';
import '../Model/Master.dart';

class CreateWorkout extends StatelessWidget {
  const CreateWorkout({Key? key}) : super(key: key);

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
          textFieldWidget("Enter workout name..."),
          const SizedBox(
            height: 25,
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(8, 0, 8, 4),
            child: Text("Type: "),
          ),
          textFieldWidget("Enter type..."),
          const SizedBox(
            height: 25,
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(8, 0, 8, 4),
            child: Text("Tags: "),
          ),
          textFieldWidget("Add tags..."),
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
                onPressed: () {},
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

  Widget textFieldWidget(tekst) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: TextField(
        cursorColor: Colors.grey,
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
}
