import 'package:Fitnessio/presentation/auth/pages/login_or_register_page.dart';
import 'package:Fitnessio/presentation/auth/pages/login_page.dart';
import 'package:Fitnessio/trainer/auth/pages/login_or_register_page.dart';
import 'package:flutter/material.dart';

class RoleSelectionPage extends StatelessWidget {
  const RoleSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Your Role'),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade300, Colors.blue.shade900],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Are you a Trainer or a Trainee?',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
              GestureDetector(
                onTap: () {
                  // Navigate to Trainer Page
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginPageTrainer()));
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Text(
                    'Trainer',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.blue.shade900,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Navigate to Trainee Page
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>LoginPage()));
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Text(
                    'Trainee',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.blue.shade900,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
