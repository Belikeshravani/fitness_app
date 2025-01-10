import 'package:flutter/material.dart';

class ExercisePage extends StatefulWidget {
  late Map<String, dynamic> user;
   ExercisePage({super.key, required user});

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
