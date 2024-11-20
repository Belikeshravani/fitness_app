import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:Fitnessio/presentation/consumption/providers/consumption_provider.dart';
import 'package:Fitnessio/presentation/consumption/widgets/new_meal_app_bar.dart';
import 'package:Fitnessio/utils/managers/asset_manager.dart';
import 'package:Fitnessio/utils/managers/color_manager.dart';
import 'package:Fitnessio/utils/managers/string_manager.dart';
import 'package:Fitnessio/utils/managers/value_manager.dart';
import 'package:Fitnessio/utils/widgets/lime_green_rounded_button.dart';
import 'package:Fitnessio/utils/widgets/small_text_field_widget.dart';
import 'package:Fitnessio/utils/widgets/text_field_underlined.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class NewMealPage extends StatefulWidget {
  const NewMealPage({super.key});

  @override
  State<NewMealPage> createState() => _NewMealPageState();
}

class _NewMealPageState extends State<NewMealPage> {
  final TextEditingController _mealTitleController = TextEditingController();
  final TextEditingController _mealCalloriesController =
      TextEditingController();
  final TextEditingController _mealAmountController = TextEditingController();
  final TextEditingController _mealFatsController = TextEditingController();
  final TextEditingController _mealCarbsController = TextEditingController();
  final TextEditingController _mealProteinsController = TextEditingController();
  final TextEditingController _mealDateController = TextEditingController();
  double valueFats = 0.0;
  double valueCarbs = 0.0;
  double valueProtein = 0.0;

  @override
  void dispose() {
    _mealTitleController.dispose();
    _mealCalloriesController.dispose();
    _mealAmountController.dispose();
    _mealCarbsController.dispose();
    _mealFatsController.dispose();
    _mealProteinsController.dispose();
    _mealDateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _mealDateController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    final consumptionProvider =
        Provider.of<ConsumptionProvider>(context, listen: false);

    //api fetch function
    void fetchapi() async {
      if (_mealTitleController.text.isEmpty ||
          _mealAmountController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please enter both meal name and amount!')),
        );
        return;
      }

      final String mealName = _mealTitleController.text;
      final String mealAmount = _mealAmountController.text;

      try {
        final model = GenerativeModel(
          model: 'gemini-1.5-flash',
          apiKey: 'AIzaSyAXczCcaNC6DFktLJz8rZ-jG0wwEdd6ZX8',
        );

        final prompt =
            'Provide nutritional content (kCal, Carbs, Fats, Proteins) in double datatype for $mealAmount grams of $mealName as a JSON object.If you do not know the nutritional value,just give some random guess,but give the answer and do not write unnecessary information.And do not give null value for any of the nutritional content';

        final response = await model.generateContent([Content.text(prompt)]);
        final String? responseText = response.text;

        // Clean the response text to extract JSON
        final cleanedResponse = responseText
            ?.replaceAll(RegExp(r'^```json'), '')
            .replaceAll(RegExp(r'```'), '')
            .trim();

        // Parse response JSON
        final Map<String, dynamic> nutritionData = jsonDecode(cleanedResponse!);

        // Safely assign values with default of 0 if null
        final double calories = (nutritionData['kcal'] ?? 0).toDouble();
        final double carbs = (nutritionData['carbs'] ?? 0).toDouble();
        final double fats = (nutritionData['fats'] ?? 0).toDouble();
        final double proteins = (nutritionData['proteins'] ?? 0).toDouble();

        // Update the UI
        setState(() {
          _mealCalloriesController.text = calories.toString();
          _mealCarbsController.text = carbs.toString();
          _mealFatsController.text = fats.toString();
          _mealProteinsController.text = proteins.toString();
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Nutritional data fetched successfully!')),
        );
      } catch (error) {
        print('Error fetching nutritional data: $error');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to fetch nutritional data.')),
        );
      }
    }

// final prompt =
//         'Provide nutritional content (kCal, Carbs, Fats, Proteins) for $mealAmount grams of $mealName as a JSON object.If you do not know the nutritional value,just give some random guess,but give the answer and do not write unnecessary information.';

//     // Fetch response
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(
          deviceWidth,
          SizeManager.s60.h,
        ),
        child: const NewMealPageAppBar(),
      ),
      backgroundColor: ColorManager.darkGrey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: PaddingManager.p8),
                child: SizedBox(
                  width: SizeManager.s250.w,
                  height: SizeManager.s250.h,
                  child: Image.asset(
                    ImageManager.fork,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: PaddingManager.p28,
                  right: PaddingManager.p28,
                ),
                child: TextFieldWidgetUnderLined(
                  readOnly: false,
                  controller: _mealTitleController,
                  labelHint: StringsManager.mealNameHint,
                  obscureText: false,
                  keyboardType: TextInputType.text,
                ),
              ),
               Padding(
                padding: const EdgeInsets.only(
                  left: PaddingManager.p28,
                  right: PaddingManager.p28,
                  top: PaddingManager.p12,
                ),
                child: GestureDetector(
                  onTap: () {
                    _selectDate(context); // Show the date picker on tap
                  },
                  child: AbsorbPointer(
                    child: TextFieldWidgetUnderLined(
                      controller: _mealDateController,
                      labelHint: "Select Meal Date",
                      keyboardType: TextInputType.none,
                      obscureText: false,
                      readOnly: true,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: PaddingManager.p28,
                  right: PaddingManager.p28,
                  top: PaddingManager.p12,
                ),
                child: TextFieldWidgetUnderLined(
                  readOnly: false,
                  controller: _mealAmountController,
                  labelHint: StringsManager.mealAmountHint,
                  keyboardType: TextInputType.number,
                  obscureText: false,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: PaddingManager.p12),
                child: TextButton(
                  onPressed: () {
                    // Unfocus any text fields to dismiss the keyboard
                    FocusScope.of(context).unfocus();
                    fetchapi(); // Call the API fetch function
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white, // Text color when clicked
                    backgroundColor:
                        ColorManager.limerGreen2, // Button background color
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // Rounded corners
                    ),
                  ),
                  child: Text(
                    "Add Nutritional Values",
                    style: TextStyle(
                      fontSize: 14.sp, // Small font size
                      color: Colors.black, // Text color
                      fontWeight: FontWeight.w500, // Medium weight
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: PaddingManager.p28,
                  right: PaddingManager.p28,
                  top: PaddingManager.p12,
                  bottom: PaddingManager.p12,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SmallTextFieldWidget(
                      controller: _mealCalloriesController,
                      labelHint: StringsManager.mealCaloriesHint,
                      obscureText: false,
                      keyboardType: TextInputType.number,
                    ),
                    SmallTextFieldWidget(
                      controller: _mealFatsController,
                      labelHint: StringsManager.mealFatsHint,
                      keyboardType: TextInputType.number,
                      obscureText: false,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: PaddingManager.p28,
                  right: PaddingManager.p28,
                  bottom: PaddingManager.p28,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SmallTextFieldWidget(
                      controller: _mealCarbsController,
                      labelHint: StringsManager.mealCarbsHint,
                      keyboardType: TextInputType.number,
                      obscureText: false,
                    ),
                    SmallTextFieldWidget(
                      controller: _mealProteinsController,
                      labelHint: StringsManager.mealProteinsHint,
                      keyboardType: TextInputType.number,
                      obscureText: false,
                    ),
                  ],
                ),
              ),
              LimeGreenRoundedButtonWidget(
                onTap: () {
                  try {
                    consumptionProvider.addNewMeal(
                      title: _mealTitleController.text,
                      amount: double.parse(_mealAmountController.text),
                      calories: double.parse(_mealCalloriesController.text),
                      fats: double.parse(_mealFatsController.text),
                      carbs: double.parse(_mealCarbsController.text),
                      proteins: double.parse(_mealProteinsController.text),
                      dateTime: _mealDateController.text.isNotEmpty
                          ? DateTime.parse(_mealDateController.text)
                          : DateTime.now(),
                    );
                    Navigator.of(context).pop();
                  } catch (e) {
                    rethrow;
                  }
                },
                title: StringsManager.add,
              )
            ],
          ),
        ),
      ),
    );
  }
}
