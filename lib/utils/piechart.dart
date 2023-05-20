import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Showpiechart {
  List<PieChartSectionData> showingSections(int touchedIndex,
      double carbspercent, double fatpercent, double proteinpercent) {
    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 18.0 : 16.0;
      final radius = isTouched ? 110.0 : 100.0;

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xFFE16162),
            value: carbspercent,
            title: carbspercent.toStringAsFixed(2),
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xff001e1d),
              fontFamily: 'Poppins',
            ),
            titlePositionPercentageOffset: 1.25,
          );
        case 1:
          return PieChartSectionData(
            color: Color(0xFFf9bc60),
            value: fatpercent,
            title: fatpercent.toStringAsFixed(2),
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xff001e1d),
              fontFamily: 'Poppins',
            ),
            titlePositionPercentageOffset: 1.25,
          );
        case 2:
          return PieChartSectionData(
            color: Color(0xFFe8e4e6),
            value: proteinpercent,
            title: proteinpercent.toStringAsFixed(2),
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xff001e1d),
              fontFamily: 'Poppins',
            ),
            titlePositionPercentageOffset: 1.25,
          );
        default:
          throw Exception('Oh no');
      }
    });
  }
}
