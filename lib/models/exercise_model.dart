class Exercise {
  //takes a name
  final String nameEx;
  final String weight;
  final String sets;
  final String reps;
  bool isCompleted;

  Exercise({
    required this.nameEx,
    required this.weight,
    required this.sets,
    required this.reps,
    this.isCompleted = false,
  });
}
