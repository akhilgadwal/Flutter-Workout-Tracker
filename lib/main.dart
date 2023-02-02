import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workouttracker/data/workout_data.dart';
import 'package:workouttracker/pages/home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

void main() async {
  //init hive
  await Hive.initFlutter();
  //open the box
  await Hive.openBox('WORKOUTDATABASE');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WorkOutData(),
      child: MaterialApp(
        home: MyHomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
