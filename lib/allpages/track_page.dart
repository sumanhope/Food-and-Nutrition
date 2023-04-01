import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class TrackPage extends StatefulWidget {
  const TrackPage({super.key});

  @override
  State<TrackPage> createState() => _TrackPageState();
}

class _TrackPageState extends State<TrackPage> {
  Widget _circleProgress() {
    return SizedBox(
      width: 160,
      height: 160,
      child: Stack(
        children: [
          SizedBox(
            width: 160,
            height: 160,
            child: CircularProgressIndicator(
              strokeWidth: 8,
              value: 0.72,
              backgroundColor: Colors.white10.withOpacity(0.2),
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              margin: const EdgeInsets.all(13),
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Remaining",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      Text(
                        "1,112",
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      Text(
                        "kcal",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _macronutrients() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _marconutrientsTile(
          title: 'Carbs',
          percentValue: 0.5,
          amountInGram: '14/323g',
        ),
        const SizedBox(
          height: 20,
        ),
        _marconutrientsTile(
          title: 'Protein',
          percentValue: 0.7,
          amountInGram: '14/129g',
        ),
        const SizedBox(
          height: 20,
        ),
        _marconutrientsTile(
          title: 'Fats',
          percentValue: 0.4,
          amountInGram: '14/85g',
        ),
      ],
    );
  }

  Widget _marconutrientsTile(
      {required String title,
      required double percentValue,
      required amountInGram}) {
    return SizedBox(
      height: 50,
      width: 130,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
            ),
          ),
          LinearPercentIndicator(
            width: 130,
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
              fontSize: 12,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          "Track your Calories",
          style: TextStyle(
            letterSpacing: 1.5,
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1.4,
            child: Container(
              padding: const EdgeInsets.all(18),
              margin: const EdgeInsets.only(
                  top: 20, left: 10, right: 10, bottom: 10),
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _circleProgress(),
                  _macronutrients(),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 120,
                height: 100,
                padding: const EdgeInsets.all(18),
                margin: const EdgeInsets.only(
                    top: 10, left: 15, right: 0, bottom: 10),
                decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              InkWell(
                onTap: () {},
                highlightColor: Colors.transparent,
                splashColor: Theme.of(context).toggleableActiveColor,
                child: Container(
                  width: 210,
                  height: 100,
                  padding: const EdgeInsets.all(18),
                  margin: const EdgeInsets.only(
                      top: 10, left: 15, right: 10, bottom: 10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: const [
                      Text(
                        "Total Calories",
                        style: TextStyle(
                          letterSpacing: 1.5,
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      Text(
                        "3000 kcal",
                        style: TextStyle(
                          letterSpacing: 1.5,
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
