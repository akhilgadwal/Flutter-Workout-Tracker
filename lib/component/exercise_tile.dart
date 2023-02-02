import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ExerciseTile extends StatelessWidget {
  final String exercisename;
  final String weigths;
  final String sets;
  final String reps;
  final bool isCompleted;
  void Function(bool?)? onCheckedBox;

  ExerciseTile({
    super.key,
    required this.exercisename,
    required this.weigths,
    required this.sets,
    required this.reps,
    required this.isCompleted,
    required this.onCheckedBox,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightBlue,
      child: ListTile(
        title: Text(exercisename),
        subtitle: Row(children: [
          Chip(label: Text('${weigths}kg')),
          const SizedBox(
            width: 5,
          ),
          Chip(label: Text('${sets}sets')),
          const SizedBox(
            width: 5,
          ),
          Chip(label: Text('${reps}reps')),
        ]),
        trailing: Checkbox(
            value: isCompleted, onChanged: (value) => onCheckedBox!(value)),
      ),
    );
  }
}
