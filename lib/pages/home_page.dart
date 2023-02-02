import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workouttracker/data/workout_data.dart';
import 'package:workouttracker/pages/workout_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //text Controller
  final newWorkoutNameController = TextEditingController();
  //function for floating actions button
  void creatWorkout() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text(
                'Create Workouts',
              ),
              content: TextField(
                controller: newWorkoutNameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Add-Workout',
                ),
              ),
              actions: [
                MaterialButton(
                  color: Colors.deepPurple,
                  onPressed: save,
                  child: const Text('Save'),
                ),
                MaterialButton(
                  color: Colors.deepPurple,
                  onPressed: cancel,
                  child: const Text('Cancel'),
                ),
              ],
            ));
  }

  //creating functions for save
  void save() {
    //get workoutname from controller
    String newWorkoutName = newWorkoutNameController.text;
    //add workoutdata to work out  list
    Provider.of<WorkOutData>(context, listen: false)
        .addWorkouts(newWorkoutName);
    Navigator.of(context).pop();
    clear();
  }

  //crreating functions for cancel
  void cancel() {
    Navigator.of(context).pop();
  }

  //create clear method
  void clear() {
    newWorkoutNameController.clear();
  }

  //creating new workou\t page for
  void goToNewWorkOutPage(String workOutName) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => WorkOutPage(
                  workOutName: workOutName,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkOutData>(
        builder: (context, value, child) => Scaffold(
              appBar: AppBar(
                title: const Text('Home-Tacker'),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: creatWorkout,
                child: const Icon(Icons.add),
              ),
              body: ListView.builder(
                  itemCount: value.workOutList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(value.getListWorkouts()[index].name),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.forward,
                        ),
                        onPressed: () => goToNewWorkOutPage(
                            value.getListWorkouts()[index].name),
                      ),
                    );
                  }),
            ));
  }
}
