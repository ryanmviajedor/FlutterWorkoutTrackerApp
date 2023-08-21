import 'package:flutter_workout_tracker_app/models/exercise.dart';

class Workout {
  final String name;
  final List<Exercise> exercises;

  Workout({
    required this.name,
    required this.exercises,
  });
}
