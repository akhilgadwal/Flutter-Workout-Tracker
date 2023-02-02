//create a class hivedatabase
import 'package:hive/hive.dart';
import 'package:workouttracker/datetime/datetime.dart';
import 'package:workouttracker/models/exercise_model.dart';
import 'package:workouttracker/models/workout_model.dart';

class HiveDataBase {
  //reference the box
  final mybox = Hive.box('WORKOUTDATABASE');

  // check if the data is already stored or not
  bool previousData() {
    if (mybox.isEmpty) {
      print('Previous no data');
      mybox.put('Start_Date', todayDateYYYYMMDD());
      return false;
    } else {
      print('Does have a data');
    }
    return true;
  }

  //return the start date time yyymmdd
  String getStartDate() {
    return mybox.get('Start_Date');
  }

  //write data
  void saveDateWorkout(List<WorkOut> workouts) {
    final workoutList = convertlistobtowl(workouts);
    final exerciseList = convertlisttoEX(workouts);

    if (isexercisecompleted(workouts)) {
      mybox.put('CompletionStatus$isexercisecompleted', 1);
      mybox.put('CompletionStatus$isexercisecompleted', 0);
    }

    //lets try to save it in hive
    mybox.put('WORKOUTS', workoutList);
    mybox.put('EXERCISES', exerciseList);
  }

  //read data
  List<WorkOut> getfromdatabase() {
    List<WorkOut> mysavedworkouts = [];

    List<String> workoutNames = mybox.get('WORKOUTS');
    final exerciseDetails = mybox.get('EXERCISES');

    //lets creat a workout object
    for (int i = 0; 1 < workoutNames.length; i++) {
      //each workout can have multiple
      List<Exercise> exerciseInEachWorkout = [];

      for (int j = 0; 1 < exerciseDetails[i]; j++) {
        //so lets add each exercise in each workouts
        exerciseInEachWorkout.add(Exercise(
            nameEx: exerciseDetails[i][j][0],
            weight: exerciseDetails[i][j][1],
            sets: exerciseDetails[i][j][2],
            reps: exerciseDetails[i][j][3],
            isCompleted: exerciseDetails[i][j][4] == 'true' ? true : false));
      }
      //lets create indi workouts
      WorkOut workOut =
          WorkOut(name: workoutNames[i], exercise: exerciseInEachWorkout);
      //lets add it in
      mysavedworkouts.add(workOut);
    }
    return mysavedworkouts;
  }

  //check if any exercise is complete
  bool isexercisecompleted(List<WorkOut> workouts) {
    //go through each exercise
    for (var workout in workouts) {
      for (var exercise in workout.exercise) {
        if (exercise.isCompleted) {
          return true;
        }
      }
    }
    return false;
  }

  //retur completion goal
  int getcompletionGoals(String yyyymmdd) {
    int completionStatus = mybox.get('CompletionStatus$yyyymmdd') ?? 0;
    return completionStatus;
  }
}

//convert the workout object into list
List<String> convertlistobtowl(List<WorkOut> workouts) {
  List<String> workOutList = [];
  for (int i = 0; 1 < workouts.length; i++) {
    workOutList.add(workouts[i].name);
  }
  return workOutList;
}
//convert exercise object into ist

List<List<List<String>>> convertlisttoEX(List<WorkOut> workouts) {
  List<List<List<String>>> exerciseList = [];

  //go through each workouts
  for (int i = 0; i < workouts.length; i++) {
    List<Exercise> exerciseinWorkout = workouts[i].exercise;

    List<List<String>> indiWorkout = [];
    for (int j = 0; j < exerciseinWorkout.length; j++) {
      List<String> indiexercise = [];
      indiexercise.addAll([
        exerciseinWorkout[j].nameEx,
        exerciseinWorkout[j].weight,
        exerciseinWorkout[j].reps,
        exerciseinWorkout[j].sets,
        exerciseinWorkout[j].isCompleted.toString(),
      ]);
      indiWorkout.add(indiexercise);
    }
    exerciseList.add(indiWorkout);
  }
  return exerciseList;
}
