import 'package:flutter/material.dart';
import 'package:flutter_workout_tracker_app/models/exercise.dart';
import 'package:flutter_workout_tracker_app/models/workout.dart';

class WorkoutData extends ChangeNotifier {
  List<Workout> workoutList = [
    Workout(
      name: "Biceps",
      exercises: [
        Exercise(
          name: "Barbel Curl",
          weight: "10",
          reps: "10-12",
          sets: "3",
        )
      ],
    )
  ];

  // get workout list
  List<Workout> getWorkoutList() {
    return workoutList;
  }

  // get lenght given workout
  int numberOfExercisesInWorkout(String workoutName) {
    Workout relevantWorkout = getRelevantWorkout(workoutName);

    return relevantWorkout.exercises.length;
  }

  // add workout
  void addWorkout(String name) {
    workoutList.add(Workout(name: name, exercises: []));

    notifyListeners();
  }

  // add exercise to workout
  void addExercise(String workoutName, String exerciseName, String weight,
      String reps, String sets) {
    Workout relevantWorkout = getRelevantWorkout(workoutName);

    relevantWorkout.exercises.add(
        Exercise(name: exerciseName, weight: weight, reps: reps, sets: sets));

    notifyListeners();
  }

  // check exercise
  void checkExercise(String workoutName, String exerciseName) {
    // find relevant exrcise in that workout
    Exercise relevantExercise = getRelevantExercise(workoutName, exerciseName);

    // check boolean to show user completed the exercise
    relevantExercise.isCompleted = !relevantExercise.isCompleted;

    notifyListeners();
  }

  // return relevant workout object, given workout name
  Workout getRelevantWorkout(String workoutName) {
    Workout relevantWorkout =
        workoutList.firstWhere((workout) => workout.name == workoutName);

    return relevantWorkout;
  }

  // return relevent exercise object, given exercise name
  Exercise getRelevantExercise(String workoutName, String exerciseName) {
    Workout relevantWorkout = getRelevantWorkout(workoutName);

    Exercise relevantExercise = relevantWorkout.exercises
        .firstWhere((exercise) => exercise.name == exerciseName);

    return relevantExercise;
  }
}
