import 'package:flutter/material.dart';
import '../Model/Workout.dart';
import '../Model/Cardio.dart';
import '../Model/Rutine.dart';
import '../Model/Master.dart';

class CreateWorkout extends StatefulWidget {
  final Master master;
  const CreateWorkout({Key? key, required this.master}) : super(key: key);

  @override
  _CreateWorkout createState() => _CreateWorkout();
}

class _CreateWorkout extends State<CreateWorkout> {
  Workout workout = Workout();
  List<Rutine> rutines = [];

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Workout'),
        backgroundColor: Colors.black,
        

      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                rutines.add(Cardio("yes",false,0,0));
              },
              child: const Text('Go back!'),
            ),
            ElevatedButton(
              onPressed: () {
                workout.addWorkout(rutines);

              },
              child: const Text('Go back!'),
            ),
          ],
        ),
      ),
    );
  }
}