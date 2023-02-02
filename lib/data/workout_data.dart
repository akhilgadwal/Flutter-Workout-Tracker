//creating Workout List
import 'package:flutter/cupertino.dart';
import 'package:workouttracker/models/workout_model.dart';

import '../models/exercise_model.dart';

//using changed notifier

class WorkOutData extends ChangeNotifier {
  //overall i need is alist of workout containing list of exercise
  //excerise must have a name and exceise

  //creating a list of workoutModel for default
  List<WorkOut> workOutList = [
    WorkOut(
      name: 'Chest',
      exercise: [
        Exercise(
          nameEx: 'Bench Press',
          weight: '23',
          sets: '4 ',
          reps: '8 ',
          isCompleted: false,
        )
      ],
    ),
    WorkOut(
      name: 'Back',
      exercise: [
        Exercise(
          nameEx: 'DeadLift',
          weight: '110',
          sets: '3 ',
          reps: '8 ',
          isCompleted: false,
        )
      ],
    ),
  ];

  //method to get the list of Workout
  List<WorkOut> getListWorkouts() {
    return workOutList;
  }

  //let the user add the workout
  void addWorkouts(String name) {
    //add a workout witht the list of blank exercise
    workOutList.add(
      WorkOut(name: name, exercise: []),
    );
    notifyListeners();
  }

  //let the user add the exercise
  void addExercise(String workOutName, String exerciseName, String weights,
      String reps, String sets) {
    //lets find the relavent workout
    WorkOut relevantWorkout = getrelevantWorkout(workOutName);
    //lets add relevant exercise
    relevantWorkout.exercise.add(
      Exercise(
        nameEx: exerciseName,
        weight: weights,
        sets: sets,
        reps: reps,
      ),
    );
    notifyListeners();
  }

  //helper methods
  //creating get relevantexercise
  WorkOut getrelevantWorkout(String workOutName) {
    WorkOut relevantWorkout =
        workOutList.firstWhere((WorkOut) => WorkOut.name == workOutName);
    return relevantWorkout;
  }

  //lets return relevant excercise
  Exercise getrelevantExercise(String workOutName, String exerciseName) {
    //lets find relevant workout
    WorkOut relevantWorkOut = getrelevantWorkout(workOutName);
    //lets find relevant exercise
    Exercise relevantExercise = relevantWorkOut.exercise
        .firstWhere((exercise) => exercise.nameEx == exerciseName);
    return relevantExercise;
  }

  //check off exercise
  void checkOffExc(String workOutName, String exerciseName) {
    Exercise relevantExercise = getrelevantExercise(workOutName, exerciseName);
    // boolean to show user has completed or not
    relevantExercise.isCompleted = !relevantExercise.isCompleted;
    notifyListeners();
  }

  //lets get the lenght of givin workouts
  int numberOfWorkouts(String workoutName) {
    WorkOut relevantWorkOuts = getrelevantWorkout(workoutName);
    return relevantWorkOuts.exercise.length;
  }
}
