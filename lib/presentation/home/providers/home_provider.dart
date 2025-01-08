import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeProvider with ChangeNotifier {
  final Map<String, dynamic> _userData = {};
  double usersBMR = 0.0;
  double basicBMR = 0.0;
  double userBMRwithGoal = 0.0;
  double usersBMI = 0.0;

  // HomeProvider() {
  //   fetchUserData();
  // }

  Future<Map<String, dynamic>> fetchUserData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Fetch the user document
        DocumentSnapshot userDataSnapshot = await FirebaseFirestore.instance
            
            .collection('users')
            .doc(user.uid)
            .get();

        // Extract the trainerEmail from the user's data
        String trainerEmail = userDataSnapshot.get('trainerEmail');
        print("trainerEmail in home Provider : $trainerEmail");
        // Fetch data from the trainer's collection
        DocumentSnapshot trainerUserDataSnapshot = await FirebaseFirestore
            .instance
            .collection('trainers')
            .doc(trainerEmail)
            .collection('users')
            .doc(user.uid)
            .get();

        // Populate the _userData map
        _userData['name'] = trainerUserDataSnapshot.get('name');
        _userData['surname'] = trainerUserDataSnapshot.get('surname');
        _userData['age'] = trainerUserDataSnapshot.get('age');
        _userData['height'] = trainerUserDataSnapshot.get('height');
        _userData['weight'] = trainerUserDataSnapshot.get('weight');
        _userData['gender'] = trainerUserDataSnapshot.get('gender');
        _userData['activity'] = trainerUserDataSnapshot.get('activity');
        _userData['bmr'] = trainerUserDataSnapshot.get('bmr');
        _userData['goal'] = trainerUserDataSnapshot.get('goal');
        _userData['bmi'] = trainerUserDataSnapshot.get('bmi');
        _userData['email'] = trainerUserDataSnapshot.get('email');
        _userData['chest'] = trainerUserDataSnapshot.get('chest');
        _userData['shoulders'] = trainerUserDataSnapshot.get('shoulders');
        _userData['biceps'] = trainerUserDataSnapshot.get('biceps');
        _userData['foreArm'] = trainerUserDataSnapshot.get('foreArm');
        _userData['waist'] = trainerUserDataSnapshot.get('waist');
        _userData['hips'] = trainerUserDataSnapshot.get('hips');
        _userData['thigh'] = trainerUserDataSnapshot.get('thigh');
        _userData['calf'] = trainerUserDataSnapshot.get('calf');

        notifyListeners();
      }
    } catch (e) {
      rethrow;
    }
    return _userData;
  }

  Map<String, dynamic> get userData => _userData;

  Future<double> getUsersBMR({
    required String gender,
    required double weight,
    required double height,
    required int age,
    required String activity,
    required String goal,
  }) async {
    const double low = 1.2;
    const double light = 1.375;
    const double moderate = 1.55;
    const double high = 1.725;
    const double veryhigh = 1.9;

    var isMan = gender == 'MAN';
    var isWoman = gender == 'WOMAN';
    if (isMan) {
      var manBmrEquation =
          88.362 + (13.397 * weight) + (4.799 * height) - (5.677 * age);
      basicBMR = manBmrEquation;
    } else if (isWoman) {
      var womanBmrEquation =
          447.593 + (9.247 * weight) + (3.098 * height) - (4.330 * age);
      basicBMR = womanBmrEquation;
    }

    switch (activity) {
      case 'LOW':
        usersBMR = basicBMR * low;
        break;
      case 'LIGHT':
        usersBMR = basicBMR * light;
        break;
      case 'MODERATE':
        usersBMR = basicBMR * moderate;
        break;
      case 'HIGH':
        usersBMR = basicBMR * high;
        break;
      case 'VERY HIGH':
        usersBMR = basicBMR * veryhigh;
        break;
      default:
        throw Exception('Invalid activity level');
    }

    switch (goal) {
      case 'LOSE':
        userBMRwithGoal = usersBMR - (usersBMR * 0.2);
        break;
      case 'MAINTAIN':
        userBMRwithGoal = usersBMR;
        break;
      case 'GAIN':
        userBMRwithGoal = usersBMR + (usersBMR * 0.2);
        break;

      default:
        throw Exception('Invalid goal');
    }

    return userBMRwithGoal;
  }

  Future<double> getUsersBMI({
    required double height,
    required double weight,
  }) async {
    double heightInMeters = height / 100;
    usersBMI = (weight / (heightInMeters * heightInMeters));
    return usersBMI;
  }
}
