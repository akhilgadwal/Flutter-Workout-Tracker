import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workouttracker/component/exercise_tile.dart';
import 'package:workouttracker/data/workout_data.dart';

class WorkOutPage extends StatefulWidget {
  final String workOutName;
  const WorkOutPage({super.key, required this.workOutName});

  @override
  State<WorkOutPage> createState() => _WorkOutPageState();
}

class _WorkOutPageState extends State<WorkOutPage> {
  //void creating function for check box
  void checkBoxTap(String workOutName, String exerciseName) {
    Provider.of<WorkOutData>(context, listen: false)
        .checkOffExc(workOutName, exerciseName);
  }

  //create Text Controller
  final exerciseNameController = TextEditingController();
  final weightsNameController = TextEditingController();
  final setsNameController = TextEditingController();
  final repsNameController = TextEditingController();
  //void function for floating action button
  void flotEx() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Add New Exercise'),
              content: Column(mainAxisSize: MainAxisSize.min, children: [
                TextField(
                  controller: exerciseNameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Exersie-Name',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: weightsNameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Weights',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: setsNameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Sets',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: repsNameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Reps',
                  ),
                ),
              ]),
              actions: [
                MaterialButton(
                  onPressed: save,
                  child: const Text('Save'),
                ),
                MaterialButton(
                  onPressed: cancel,
                  child: const Text('Cancel'),
                ),
              ],
            ));
  }

  //creating functions for save
  void save() {
    //get workoutname from controller
    String exerciseName = exerciseNameController.text;
    String weights = weightsNameController.text;
    String reps = repsNameController.text;
    String sets = setsNameController.text;

    //add workoutdata to work out  list
    Provider.of<WorkOutData>(context, listen: false).addExercise(
      widget.workOutName,
      exerciseName,
      weights,
      reps,
      sets,
    );
    Navigator.of(context).pop();
    clear();
  }

  //crreating functions for cancel
  void cancel() {
    Navigator.of(context).pop();
  }

  //create clear method
  void clear() {
    exerciseNameController.clear();
    weightsNameController.clear();
    setsNameController.clear();
    repsNameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkOutData>(
      builder: ((context, value, child) => Scaffold(
            appBar: AppBar(title: Text(widget.workOutName)),
            //creating floating actions butons
            floatingActionButton: FloatingActionButton(
              onPressed: flotEx,
              child: const Icon(Icons.add),
            ),
            body: ListView.builder(
                itemCount: value.numberOfWorkouts(widget.workOutName),
                itemBuilder: (context, index) => ExerciseTile(
                      exercisename: value
                          .getrelevantWorkout(widget.workOutName)
                          .exercise[index]
                          .nameEx,
                      weigths: value
                          .getrelevantWorkout(widget.workOutName)
                          .exercise[index]
                          .weight,
                      sets: value
                          .getrelevantWorkout(widget.workOutName)
                          .exercise[index]
                          .sets,
                      reps: value
                          .getrelevantWorkout(widget.workOutName)
                          .exercise[index]
                          .reps,
                      isCompleted: value
                          .getrelevantWorkout(widget.workOutName)
                          .exercise[index]
                          .isCompleted,
                      onCheckedBox: (val) => checkBoxTap(
                        widget.workOutName,
                        value
                            .getrelevantWorkout(widget.workOutName)
                            .exercise[index]
                            .nameEx,
                      ),
                    )),
          )),
    );
  }
}
