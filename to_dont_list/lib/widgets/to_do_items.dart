import 'package:flutter/material.dart';
import 'package:to_dont_list/objects/pokemon.dart';

typedef ToDoListChangedCallback = Function(Pokemon item, bool caught);
typedef ToDoListRemovedCallback = Function(Pokemon item);

class ToDoListItem extends StatelessWidget {
  const ToDoListItem(
      {required this.item,
      required this.caught,
      super.key
      });

  final Pokemon item;
  final bool caught;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final typeColor = switch (item.type) {
      "fire" => colors.tertiary,
      "grass" => colors.primary,
      "water" => colors.secondary,
      _ => Colors.grey,
    };

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: typeColor,
        child: Text(item.abbrev()),
      ),
      title: Text(item.name),
      subtitle: Text(
        caught? "Caught: ${item.count}" : "Not caught",
      ),
      trailing: caught
      ? const Icon(Icons.check_circle, color: Colors.lightGreen,)
      : const Icon(Icons.check_circle_outline, color: Colors.grey)
      // Perhaps a unit test to check if the checkmark are working
    );
  }
}
