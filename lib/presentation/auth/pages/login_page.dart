import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:Fitnessio/presentation/auth/providers/auth_provider.dart';
import 'package:Fitnessio/utils/managers/asset_manager.dart';
import 'package:Fitnessio/utils/managers/color_manager.dart';
import 'package:Fitnessio/utils/managers/string_manager.dart';
import 'package:Fitnessio/utils/managers/style_manager.dart';
import 'package:Fitnessio/utils/managers/value_manager.dart';
import 'package:Fitnessio/utils/router/router.dart';
import 'package:Fitnessio/utils/widgets/lime_green_rounded_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signIn(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    try {
      await authProvider.signIn(
        email: _emailController.text,
        password: _passwordController.text,
        context: context,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.darkGrey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(PaddingManager.p12),
            child: Column(
              children: [
                SizedBox(
                  width: SizeManager.s250.w,
                  height: SizeManager.s250.h,
                  child: Image.asset(ImageManager.logo),
                ),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: "Email",
                  ),
                ),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(Routes.forgotPasswordRoute);
                    },
                    child: Text(
                      StringsManager.forgotPassword,
                      style: StyleManager.loginPageSubTextTextStyle,
                    ),
                  ),
                ),
                LimeGreenRoundedButtonWidget(
                  onTap: () => _signIn(context),
                  title: StringsManager.signIn,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      StringsManager.dontHaveAcc,
                      style: StyleManager.loginPageSubTextTextStyle,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(Routes.registerRoute);
                      },
                      child: Text(
                        StringsManager.signUp,
                        style: StyleManager.loginPageSubButtonSmallTextStyle,
                      ),
                    ),
                  ],
                ),
              ],
            ).animate().fadeIn(duration: 500.ms),
          ),
        ),
      ),
    );
  }
}
