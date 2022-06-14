import 'package:flutter/material.dart';
import 'package:fitness_body_app/Model/Cardio.dart';
import 'package:fitness_body_app/Model/Rutine.dart';
import 'package:fitness_body_app/Model/OtherRutine.dart';
import 'package:fitness_body_app/Model/Strength.dart';

class CreateRutine extends StatefulWidget {
  const CreateRutine({Key? key}) : super(key: key);

  @override
  _CreateRutineState createState() => _CreateRutineState();
}

class _CreateRutineState extends State<CreateRutine> {
  var durationController = TextEditingController();
  var distanceController = TextEditingController();
  var repitionsController = TextEditingController();
  String optionsValue = 'Cardio';

  int duration = 0;
  int repitions = 0;
  int distance = 0;
  String name = '';

  var options = [
    'Cardio',
    'Strength',
    'Other',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Rutine To Workout"),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 120),
            DropdownButton(
              value: optionsValue,
              icon: const Icon(Icons.keyboard_arrow_down),
              items: options.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  optionsValue = newValue!;
                  distance = 0;
                  duration = 0;
                  repitions = 0;
                  repitionsController.clear();
                  durationController.clear();
                  distanceController.clear();
                });
              },
            ),
            RutineWidget(),
            ElevatedButton(
              onPressed: () {
                Rutine? toAdd;
                if (optionsValue == "Strenght") {
                  toAdd = Strength(
                      name: name,
                      public: false,
                      repetitions: repitions,
                      duration: duration);
                } else if (optionsValue == "Cardio") {
                  toAdd = Cardio(
                      name: name,
                      public: false,
                      distance: distance,
                      duration: duration);
                } else {
                  toAdd = OtherRutine(
                      name: name,
                      public: false,
                      repetition: repitions,
                      duration: duration,
                      distance: distance);
                }
                Navigator.pop(context, toAdd);
              },
              style: ElevatedButton.styleFrom(
                primary: const Color.fromARGB(255, 190, 24, 12),
              ),
              child: const Text("Add Rutine", style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }

  Widget RutineWidget() {
    if (optionsValue == "Cardio") {
      return Column(
        children: [
          nameTextField(),
          const SizedBox(
            height: 20,
          ),
          Row(children: [
            const SizedBox(width: 10),
            ExpTextField("Distance", distanceController),
            const SizedBox(
              width: 20,
            ),
            ExpTextField("Duration", durationController),
            const SizedBox(width: 10),
          ])
        ],
      );
    } else if (optionsValue == "Strength") {
      return Column(
        children: [
          nameTextField(),
          const SizedBox(
            height: 20,
          ),
          Row(children: [
            const SizedBox(width: 10),
            ExpTextField("Repitions", repitionsController),
            const SizedBox(
              width: 20,
            ),
            ExpTextField("Duration", durationController),
            const SizedBox(width: 10),
          ])
        ],
      );
    } else {
      return Column(
        children: [
          nameTextField(),
          const SizedBox(
            height: 20,
          ),
          Row(children: [
            const SizedBox(width: 10),
            ExpTextField("Distance", distanceController),
            const SizedBox(
              width: 10,
            ),
            ExpTextField("Duration", durationController),
            const SizedBox(width: 10),
            ExpTextField("Repitions", repitionsController),
            const SizedBox(
              width: 10,
            )
          ])
        ],
      );
    }
  }

  Widget ExpTextField(content, controller) {
    return Expanded(
      child: TextField(
        cursorColor: Colors.grey,
        controller: controller,
        onChanged: (value) {
          setValue(content, value);
        },
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
          labelText: content,
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

  Widget nameTextField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: TextField(
        cursorColor: Colors.grey,
        onChanged: (value) {
          name = value;
        },
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
          labelText: "Name",
          labelStyle: (TextStyle(color: Colors.grey, fontSize: 15)),
          filled: true,
          fillColor: Color(0xFFE0E0E0),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.grey),
          ),
        ),
      ),
    );
  }

  void setValue(content, value) {
    if (content == "Duration") {
      setState(() {
        try {
          duration = int.parse(value);
        } catch (e) {
          print(e);
        }
      });
    } else if (content == "Repitions") {
      setState(() {
        try {
          duration = int.parse(value);
        } catch (e) {
          print(e);
        }
      });
    } else {
      setState(() {
        try {
          duration = int.parse(value);
        } catch (e) {
          print(e);
        }
      });
    }
  }
}
