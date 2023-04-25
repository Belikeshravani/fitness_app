import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:smart_home_app/utils/managers/color_manager.dart';
import 'package:smart_home_app/utils/managers/font_manager.dart';
import 'package:smart_home_app/utils/managers/value_manager.dart';

class PercentValueOfMeal extends StatelessWidget {
  const PercentValueOfMeal({
    super.key,
    required this.value,
    required this.amount,
    required this.title,
  });

  final double value;
  final double amount;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            bottom: PaddingManager.p12,
          ),
          child: RotatedBox(
            quarterTurns: 3,
            child: LinearPercentIndicator(
              percent: (value / amount),
              width: SizeManager.s60,
              backgroundColor: ColorManager.grey3,
              progressColor: ColorManager.limerGreen2,
              lineHeight: SizeManager.s8,
              animation: true,
              barRadius: const Radius.circular(RadiusManager.r15),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: PaddingManager.p8,
            bottom: PaddingManager.p12,
          ),
          child: Column(
            children: [
              Text(
                '${value.round()}g',
                style: const TextStyle(
                  fontSize: FontSize.s18,
                  color: ColorManager.white,
                  fontWeight: FontWightManager.bold,
                  letterSpacing: SizeManager.s1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: PaddingManager.p3,
                ),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: FontSize.s16,
                    color: ColorManager.white2,
                    fontWeight: FontWightManager.regular,
                    letterSpacing: SizeManager.s1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}