import 'package:Fitnessio/roles_page.dart';
import 'package:Fitnessio/trainer/auth/pages/add_trainer_data.dart';
import 'package:Fitnessio/trainer/auth/provider/auth_provider_trainer.dart';
import 'package:Fitnessio/trainer/presentation/trainer_main_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Fitnessio/presentation/auth/pages/add_data_page.dart';
import 'package:Fitnessio/presentation/auth/providers/auth_provider.dart';
import 'package:Fitnessio/presentation/main/pages/main_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiProvider(
        providers: [
          ChangeNotifierProvider<AuthProvider>(
            create: (_) => AuthProvider(),
          ),
          ChangeNotifierProvider<AuthProviderTrainer>(
            create: (_) => AuthProviderTrainer(),
          ),
        ],
        child: Consumer2<AuthProvider, AuthProviderTrainer>(
          builder: (context, authProvider, authProviderTrainer, _) {
            final user = authProvider.user;
            final hasAgeParameter = authProvider.hasAgeParameter;
            final trainer = authProviderTrainer.user;
            final trainerHasAgeParameter = authProviderTrainer.hasAgeParameter;

            print('Trainer: ${trainer?.email}, Has Age Parameter: $trainerHasAgeParameter');
print('User: ${user?.email}, Has Age Parameter: $hasAgeParameter');


            // If both user and trainer are null, show a message or fallback screen
            if (user == null && trainer == null) {
              // You can also show a timeout message here or fallback
              return const RoleSelectionPage();
            }

            // Trainer logic
           if (trainer != null) {
  if (trainerHasAgeParameter == true) {
    return const TrainerMainPage();  // If trainer has age parameter, navigate to the main trainer page
  } else {
    return const AddTrainerDataPage();  // Otherwise, prompt for age parameter
  }
}


            // User logic
            if (user != null && hasAgeParameter == true) {
              return const MainPage();
            }

            // Fallback
            return const RoleSelectionPage();
          },
        ),
      ),
    );
  }
}
