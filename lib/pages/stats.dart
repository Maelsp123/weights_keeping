import 'package:flutter/material.dart';
import 'package:weights_keeping/components/bar_graph.dart';

class Stats extends StatefulWidget {
  final List weights;
  const Stats({super.key, required this.weights});

  @override
  State<Stats> createState() => _StatsState();
}

class _StatsState extends State<Stats> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 300,
        child: BarGraph(
          weeklySummary: widget.weights,
        ),
      ),
    );
  }
}
