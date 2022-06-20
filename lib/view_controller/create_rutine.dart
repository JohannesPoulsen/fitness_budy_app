import 'package:flutter/material.dart';
import 'package:fitness_body_app/model/cardio.dart';
import 'package:fitness_body_app/model/rutine.dart';
import 'package:fitness_body_app/model/other_rutine.dart';
import 'package:fitness_body_app/model/strength.dart';
import 'package:fitness_body_app/model/app_master.dart';
import 'package:fitness_body_app/widgets/error_box.dart';

class CreateRutine extends StatefulWidget {
  const CreateRutine({Key? key, required this.master, this.rutine}) : super(key: key);
  final Master master;
  final Rutine? rutine;
  @override
  _CreateRutineState createState() => _CreateRutineState();
}

class _CreateRutineState extends State<CreateRutine> {
  TextEditingController durationController = TextEditingController();
  TextEditingController distanceController = TextEditingController();
  TextEditingController repitionsController = TextEditingController();
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
  initState() {
    super.initState();
    if (widget.rutine !=null){
      Rutine r = widget.rutine!;
      if(r.isAdded){
        if(r is Cardio){
          Cardio c = r as Cardio;
          optionsValue = 'Cardio';

          duration = c.duration!;
          distance = c.distance!;
          name = c.name;
        }
        if(r is Strength){
          Strength s = r as Strength;
          optionsValue = 'Strength';

          duration = s.duration!;
          repitions = s.repetitions!;
          name = s.name;
        }
        if(r is OtherRutine){
          OtherRutine o = r as OtherRutine;
          optionsValue = 'Other';

          duration = o.duration!;
          distance = o.distance!;
          repitions = o.repetitions!;
          name = o.name;
        }
      }
    }
  }

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
                if (name.isNotEmpty) {
                  if (optionsValue == "Strength") {
                    toAdd = Strength(
                        name: name,
                        repetitions: repitions,
                        sets: duration);
                  } else if (optionsValue == "Cardio") {
                    toAdd = Cardio(
                        name: name,
                        distance: distance,
                        duration: duration);
                  } else {
                    toAdd = OtherRutine(
                        name: name,
                        repetitions: repitions,
                        duration: duration,
                        distance: distance);
                  }
                  Navigator.pop(context, toAdd);
                } else {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return const ErrorBox(
                          errorName: 'Unnamed Parameter',
                          errorReason: 'Rutine must have a name',
                        );
                      });
                }
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
            ExpTextField("Distance", distanceController, distance),
            const SizedBox(
              width: 20,
            ),
            ExpTextField("Duration", durationController, duration),
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
            ExpTextField("Repitions", repitionsController, repitions),
            const SizedBox(
              width: 20,
            ),
            ExpTextField("Sets", durationController, duration),
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
            ExpTextField("Distance", distanceController, distance),
            const SizedBox(
              width: 10,
            ),
            ExpTextField("Duration", durationController, duration),
            const SizedBox(width: 10),
            ExpTextField("Repitions", repitionsController, repitions),
            const SizedBox(
              width: 10,
            )
          ])
        ],
      );
    }
  }

  Widget ExpTextField(content, TextEditingController controller, initial) {
    return Expanded(
      child: TextField(
        cursorColor: Colors.grey,
        controller: controller..text = '$initial',
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
        controller: TextEditingController()..text = name,
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
    if (content == "Duration" || content == "Sets") {
      try {
          duration = int.parse(value);
        } catch (e) {
          print(e);
        }
    } else if (content == "Repitions") {
      try {
          repitions = int.parse(value);
        } catch (e) {
          print(e);
        }
    } else {
        try {
          distance = int.parse(value);
        } catch (e) {
          print(e);
        }
    }
  }
}
