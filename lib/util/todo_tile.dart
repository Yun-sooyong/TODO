import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoTile extends StatelessWidget {
  final String taskName;
  final bool isTaskCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext?) deleteTask;

  TodoTile({
    Key? key,
    required this.taskName,
    required this.isTaskCompleted,
    required this.onChanged,
    required this.deleteTask,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteTask,
              icon: Icons.delete,
              backgroundColor: Colors.red.shade300,
              borderRadius: const BorderRadius.all(Radius.circular(24)),
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.deepPurple[300],
            borderRadius: BorderRadius.circular(24),
          ),
          child: Row(
            children: [
              Checkbox(value: isTaskCompleted, onChanged: onChanged),
              Text(
                taskName,
                style: TextStyle(
                  decoration: isTaskCompleted
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
