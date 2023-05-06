/*
For men: BMR = 88.362 + (13.397 x weight in kg) + (4.799 x height in cm) - (5.677 x age in years)
For women: BMR = 447.593 + (9.247 x weight in kg) + (3.098 x height in cm) - (4.330 x age in years)

Total daily calorie intake = BMR x activity factor

Sedentary: If you do little to no exercise, your activity factor is 1.2.
Lightly active: If you exercise 1-3 days per week, your activity factor is 1.375.
Moderately active: If you exercise 3-5 days per week, your activity factor is 1.55.
Very active: If you exercise 6-7 days per week, your activity factor is 1.725.
Extremely active: If you exercise twice per day or have a physically demanding job, your activity factor is 1.9.
*/

import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class MacroTiles extends StatelessWidget {
  const MacroTiles({
    Key? key,
    required this.title,
    required this.percentValue,
    required this.amountInGram,
  }) : super(key: key);

  final String title;
  final double percentValue;
  final String amountInGram;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
            ),
          ),
          LinearPercentIndicator(
            width: 200,
            animation: true,
            lineHeight: 6,
            animationDuration: 1500,
            percent: percentValue,
            barRadius: const Radius.circular(3),
            padding: EdgeInsets.zero,
            backgroundColor:
                const Color.fromARGB(184, 255, 255, 255).withOpacity(0.3),
            progressColor: Colors.white,
          ),
          Text(
            amountInGram,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }
}

class CircleProgress extends StatelessWidget {
  const CircleProgress({
    Key? key,
    required this.percentcal,
    required this.foodcal,
    required this.basecal,
    required this.remaining,
  }) : super(key: key);

  final double percentcal;
  final double foodcal;
  final double basecal;
  final double remaining;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 170,
      height: 170,
      child: Stack(
        children: [
          SizedBox(
            width: 170,
            height: 170,
            child: CircularProgressIndicator(
              strokeWidth: 8,
              value: percentcal,
              backgroundColor: Colors.white10.withOpacity(0.2),
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color.fromARGB(88, 242, 242, 242),
                  width: 6,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.2),
                ),
                child: Container(
                  margin: const EdgeInsets.all(22),
                  child: foodcal != basecal
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 150,
                              child: Text(
                                "Remaining",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ),
                            Text(
                              "$remaining",
                              style: const TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            const Text(
                              "kcal",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ],
                        )
                      : const Center(
                          child: SizedBox(
                            width: 150,
                            child: Text(
                              "All done",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                        ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MacroNutrients extends StatelessWidget {
  const MacroNutrients({
    Key? key,
    required this.basecarb,
    required this.carb,
    required this.perccarbs,
    required this.baseprot,
    required this.prot,
    required this.percprot,
    required this.basefat,
    required this.fat,
    required this.percfats,
  }) : super(key: key);

  final double basecarb;
  final double carb;
  final double perccarbs;
  final double baseprot;
  final double prot;
  final double percprot;
  final double basefat;
  final double fat;
  final double percfats;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        MacroTiles(
            title: 'Carbs',
            percentValue: perccarbs,
            amountInGram: '$carb/${basecarb}g'),
        const SizedBox(
          height: 5,
        ),
        MacroTiles(
            title: 'Protein',
            percentValue: perccarbs,
            amountInGram: '$prot/${baseprot}g'),
        const SizedBox(
          height: 5,
        ),
        MacroTiles(
            title: 'Fats',
            percentValue: percfats,
            amountInGram: '$fat/${basefat}g'),
      ],
    );
  }
}
