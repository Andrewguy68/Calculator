// Started with https://docs.flutter.dev/development/ui/widgets-intro
// update some of the imports for new file names
import 'package:flutter/material.dart';
import 'package:workout_tracker/objects/exercise.dart';
import 'package:workout_tracker/widgets/exercise_list_item.dart';
import 'package:workout_tracker/widgets/exercise_dialog.dart';

final ThemeData workoutTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 84, 215, 204),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromARGB(255, 15, 118, 110),
    foregroundColor: Color.fromARGB(255, 205, 184, 184),
    titleTextStyle: TextStyle(
      fontSize: 24,
      color: Color.fromARGB(255, 0, 0, 0),
    ),
  ),
  textTheme: const TextTheme(
    titleLarge: TextStyle(fontSize: 24),
    titleMedium: TextStyle(fontSize: 18),
    bodyLarge: TextStyle(fontSize: 16),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color.fromARGB(255, 87, 171, 189),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ),
);

// swap out the old list stuff for new WorkoutList/WorkoutTracker stuff
class WorkoutList extends StatefulWidget {
  const WorkoutList({super.key});

  @override
  State createState() => _WorkoutListState();
}

// Stateful widgets always are paried with a state smth
// type stf for stateful
// type st for stateless
class _WorkoutListState extends State<WorkoutList> {
  final List<Exercise> items = [Exercise(name: "Push-ups", muscleGroup: MuscleGroup.chest)];
  
  void _handleDeleteExercise(Exercise exercise) {
    setState(() {
      print("Deleting exercise");
      items.remove(exercise);
    });
  }

  void _handleNewExercise(String exerciseText, MuscleGroup targetMuscle, TextEditingController textController) {
    setState(() {
      print("Adding new exercise");

      // have to add those new parameter
      Exercise exercise = Exercise(name: exerciseText, muscleGroup: targetMuscle);
      items.insert(0, exercise);
      textController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Workout Tracker'),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          children: items.map((exercise) {
            return ExerciseListItem(
              exercise: exercise,
              onDeleteExercise: _handleDeleteExercise,
            );
          }).toList(),
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) {
                    return ExerciseDialog(onListAdded: _handleNewExercise);
                  });
            }));
  }
}

void main() {
  runApp(MaterialApp(
    title: 'Workout Tracker',
    theme: workoutTheme,
    home: WorkoutList(),
  ));
}
