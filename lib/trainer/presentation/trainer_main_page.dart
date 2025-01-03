import 'package:Fitnessio/presentation/main/widgets/appbar_home.dart';
import 'package:Fitnessio/trainer/auth/provider/auth_provider_trainer.dart';
import 'package:Fitnessio/trainer/home/provider/trainer_home_provider.dart';
import 'package:Fitnessio/trainer/home/widgets/home_page_appbar.dart';
import 'package:Fitnessio/utils/managers/style_manager.dart';
import 'package:Fitnessio/utils/managers/value_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class TrainerMainPage extends StatefulWidget {
  const TrainerMainPage({super.key});

  @override
  State<TrainerMainPage> createState() => _TrainerMainPageState();
}

class _TrainerMainPageState extends State<TrainerMainPage> {
  String? trainerName;
  String? trainerSurname;

  @override
  void initState() {
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<AuthProviderTrainer>(context).user;
    TrainerHomeProvider trainerHomeProvider =
        Provider.of<TrainerHomeProvider>(context);
    trainerHomeProvider.fetchTrainerData();

    // Show a fallback UI if the user is null
    if (user == null) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: const Center(
          child: Text(
            'No user is logged in.',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: Size(
          double.infinity,
          SizeManager.s60.h,
        ),
        child: const HomePageAppbar(),
      ),
      body: Padding(
        padding: EdgeInsets.all(SizeManager.s16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Message
            Text(
                    'Welcome ${trainerHomeProvider.userData['name']} ${trainerHomeProvider.userData['surname']}!',
                    style: StyleManager.homeTitleDataTextStyle,
                  ),
            const SizedBox(height: 10),

            // Search Bar
            TextField(
              decoration: InputDecoration(
                hintText: "Search users...",
                hintStyle: TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.grey[900],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              ),
              style: const TextStyle(color: Colors.white),
              onChanged: (value) {
                // Add search functionality here
              },
            ),
            const SizedBox(height: 20),

            // Placeholder for User List
            Expanded(
              child: ListView.builder(
                itemCount: 5, // Replace with dynamic count of users
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.grey[800],
                    child: ListTile(
                      title: Text(
                        "User $index", // Replace with user data
                        style: const TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        "Progress: 75%", // Replace with user progress
                        style: const TextStyle(color: Colors.grey),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                      ),
                      onTap: () {
                        // Navigate to user details
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      // Add Trainee Button
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          // Navigate to Add Trainee Page
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
