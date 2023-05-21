import 'package:charts_flutter/flutter.dart' as charts;

class BarChartModel {
  String day;
  int waterlevel;
  final charts.Color color;

  BarChartModel({
    required this.day,
    required this.waterlevel,
    required this.color,
  });
}
