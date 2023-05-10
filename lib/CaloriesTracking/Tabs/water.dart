import 'package:flutter/material.dart';

class WaterTab extends StatefulWidget {
  const WaterTab({super.key});

  @override
  State<WaterTab> createState() => _WaterTabState();
}

class _WaterTabState extends State<WaterTab> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Water levels"),
    );
  }
}
