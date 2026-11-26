import 'package:flutter/material.dart';
import 'package:workout_tracker/objects/exercise.dart';

typedef ExerciseAddedCallback = Function(String value, MuscleGroup targetMuscle,
    TextEditingController textController);

class ExerciseDialog extends StatefulWidget {
  const ExerciseDialog({
    super.key,
    required this.onListAdded,
  });

  final ExerciseAddedCallback onListAdded;

  @override
  State<ExerciseDialog> createState() => _ExerciseDialogState();
}

class _ExerciseDialogState extends State<ExerciseDialog> {
  final TextEditingController _inputController = TextEditingController();

  String valueText = "";
  MuscleGroup valueMuscle = MuscleGroup.chest;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Exercise To Add'),
      content: Column(
        children: [
          TextField(
            onChanged: (value) {
              setState(() {
                valueText = value;
              });
            },
            controller: _inputController,
            decoration:
                const InputDecoration(hintText: "type exercise name here"),
          ),
          // setState() here updates the valueMuscle variable
          // also hides the drop down, showing the sekleted muscle target
          DropdownButton<MuscleGroup>(
            value: valueMuscle,
            items: MuscleGroup.values.map((group) {
              return DropdownMenuItem(
                value: group,
                child: Text(group.name),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                // update the targeted muscle
                valueMuscle = newValue!;
              });
            },
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          key: const Key('CancelButton'),
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        ValueListenableBuilder<TextEditingValue>(
          valueListenable: _inputController,
          builder: (context, value, child) {
            return ElevatedButton(
              key: const Key("OKButton"),
              onPressed: value.text.isNotEmpty
                  ? () {
                      setState(() {
                        widget.onListAdded(
                            valueText, valueMuscle, _inputController);
                        Navigator.pop(context);
                      });
                    }
                  : null,
              child: const Text('OK'),
            );
          },
        ),
      ],
    );
  }
}
