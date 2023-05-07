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
            color: Colors.indigo,
            value: carbspercent,
            title: carbspercent.toStringAsFixed(2),
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              fontFamily: 'Poppins',
            ),
            titlePositionPercentageOffset: 1.2,
          );
        case 1:
          return PieChartSectionData(
            color: Colors.yellow,
            value: fatpercent,
            title: fatpercent.toStringAsFixed(2),
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              fontFamily: 'Poppins',
            ),
            titlePositionPercentageOffset: 1.2,
          );
        case 2:
          return PieChartSectionData(
            color: Colors.blue,
            value: proteinpercent,
            title: proteinpercent.toStringAsFixed(2),
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              fontFamily: 'Poppins',
            ),
            titlePositionPercentageOffset: 1.2,
          );
        default:
          throw Exception('Oh no');
      }
    });
  }
}

class _Badge extends StatelessWidget {
  const _Badge({
    required this.icon,
    required this.size,
    required this.borderColor,
  });

  final double size;
  final IconData icon;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: PieChart.defaultDuration,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: 2,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(.5),
            offset: const Offset(3, 3),
            blurRadius: 3,
          ),
        ],
      ),
      padding: EdgeInsets.all(size * .15),
      child: Center(
        child: Icon(icon),
      ),
    );
  }
}
