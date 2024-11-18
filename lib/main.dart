import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:Fitnessio/app/app.dart';
import 'package:Fitnessio/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Check if Firebase is already initialized before initializing
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      name: "fitness-app-2-69c87",
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print("Fitness Project connecteddddd");
  } else {
    print("Firebase is already initialized");
  }

  runApp(MyApp());
}
