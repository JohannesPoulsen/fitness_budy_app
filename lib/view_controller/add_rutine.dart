import 'package:fitness_body_app/model/cardio.dart';
import 'package:fitness_body_app/model/other_rutine.dart';
import 'package:fitness_body_app/model/strength.dart';
import 'package:flutter/material.dart';
import 'package:fitness_body_app/model/app_master.dart';
import 'package:fitness_body_app/model/workout.dart';
import 'package:fitness_body_app/view_controller/create_rutine.dart';
import 'package:fitness_body_app/model/rutine.dart';
import 'package:fitness_body_app/services/firestore_upload.dart';
import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fitness_body_app/widgets/menu_items.dart';

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
                FirestoreUpload.uploadPublicWorkout(widget.workout);
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: const Icon(
                Icons.save,
                size: 26.0,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              widget.workout.workoutName,
              style: const TextStyle(
                fontSize: 30,
              ),
            ),
            ReorderableListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: listOfRutines.length,
              itemBuilder: (context, index) {
                return Card(
                  key: Key('$index'),
                  color: tileColorInList(listOfRutines[index]),
                  child: ListTile(
                    trailing: DropdownButton2(
                      customButton: const Icon(
                        Icons.more_vert,
                      ),
                      customItemsIndexes: const [2],
                      customItemsHeight: 8,
                      items: [
                        ...MenuItems.firstItems.map(
                          (item) => DropdownMenuItem<MenuItem2>(
                            value: item,
                            child: MenuItems.buildItem(item),
                          ),
                        ),
                      ],
                      onChanged: (value) {
                        switch (value) {
                          case MenuItems.clone:
                            setState(() {
                              if (listOfRutines[index] is Strength) {
                                Strength clone =
                                    listOfRutines[index] as Strength;
                                clone.newStrength(clone.name,
                                    clone.url, clone.repetitions, clone.sets);
                                listOfRutines.add(clone);
                                rutines.add(clone.name);
                              } else if (listOfRutines[index] is Cardio) {
                                Cardio clone = listOfRutines[index] as Cardio;
                                clone.newCardio(clone.name,
                                    clone.url, clone.distance, clone.duration);
                                listOfRutines.add(clone);
                                rutines.add(clone.name);
                              } else if (listOfRutines[index] is OtherRutine) {
                                OtherRutine clone =
                                    listOfRutines[index] as OtherRutine;
                                clone.newOtherRutine(
                                    clone.name,
                                    clone.url,
                                    clone.distance,
                                    clone.duration,
                                    clone.repetitions);
                                listOfRutines.add(clone);
                                rutines.add(clone.name);
                              }
                            });
                            break;
                          case MenuItems.delete:
                            removeRutine(index);
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
      ),
      floatingActionButton: addRutineKnap(),
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
      return Text("Repetitions: ${rutine.repetitions} - Sets: ${rutine.sets}");
    } else {
      return Text(
          "Repetitions: ${rutine.repetitions} - Duration: ${rutine.duration} - Distance: ${rutine.distance}");
    }
  }

  Widget addRutineKnap() {
    if (rutines.length < 6) {
      return FloatingActionButton.extended(
        label: const Text("Add New Rutine"),
        heroTag: 'btn1',
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
        heroTag: 'btn2',
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
        child: const Icon(
          Icons.add,
        ),
      );
    }
  }

  void removeRutine(index) {
    setState(() {
      rutines.removeAt(index);
      listOfRutines.removeAt(index);
    });
  }

  void initRutinesList() {
    setState(() {
      for (Rutine r in widget.workout.workoutList) {
        rutines.add(r.name);
      }
    });
  }
}
