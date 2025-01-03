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
            var isRegisteredUser = user != null && hasAgeParameter == true;
            var isAddDataMode = user != null && hasAgeParameter == false;

            final trainer = authProviderTrainer.user;
            final trainerHasAgeParameter = authProviderTrainer.hasAgeParameter;
            var isTrainerRegisteredUser =
                trainer != null && trainerHasAgeParameter == true;
            var isTrainerAddDataMode =
                trainer != null && trainerHasAgeParameter == false;

            if (user != null && trainer == null) {
              if (isRegisteredUser) {
                return const MainPage();
              } else if (isAddDataMode) {
                return const AddDataPage();
              } 
            }
            else if (trainer != null && user == null) {
              if (isTrainerRegisteredUser) {
                return const TrainerMainPage();
              } else if (isTrainerAddDataMode) {
                return const AddTrainerDataPage();
              } 
            }
            
              return const RoleSelectionPage();
            


          },
        ),
      ),
    );
  }
}
