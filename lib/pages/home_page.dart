import 'package:flutter/material.dart';
import 'package:flutter_workout_tracker_app/data/workout_data.dart';
import 'package:flutter_workout_tracker_app/pages/workout_page.dart';
import 'package:flutter_workout_tracker_app/util/dialog_box.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //text controller
  final newWorkoutNameController = TextEditingController();

  // create a new workout
  void createNewWorkout() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: newWorkoutNameController,
          onSave: save,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  // goToWorkoutPage
  void goToWorkoutPage(String workoutName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WorkoutPage(
          workoutName: workoutName,
        ),
      ),
    );
  }

  // Save new task
  void save() {
    String newWorkoutName = newWorkoutNameController.text;
    Provider.of<WorkoutData>(context, listen: false).addWorkout(newWorkoutName);
    newWorkoutNameController.clear();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutData>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: const Text("Workout Tracker"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: createNewWorkout,
          child: Icon(Icons.add),
        ),
        body: ListView.builder(
          itemCount: value.getWorkoutList().length,
          itemBuilder: (context, index) => ListTile(
            title: Text(value.getWorkoutList()[index].name),
            trailing: IconButton(
              onPressed: () =>
                  goToWorkoutPage(value.getWorkoutList()[index].name),
              icon: Icon(Icons.arrow_forward_ios),
            ),
          ),
        ),
      ),
    );
  }
}
