import 'package:flutter/material.dart';

import '../components/appbar.dart';
import '../components/day.dart';

class Calendar extends StatelessWidget {
  Calendar({super.key});

  final children = <Widget>[];
  final cur_date = DateTime.utc(2024, 1);



  @override
  Widget build(BuildContext context) {
    final month_length = [31, (cur_date.year/4.0)==(cur_date.year/4.0).roundToDouble() ? 29 : 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

    for (var i = 0; i < 35; i++) {
      DateTime date = DateTime.utc(cur_date.year, cur_date.month, i+1);
      children.add(JobEntry(date: date));
    }

    return Scaffold(
      appBar: Appbar(),
      body: Center(
        child: GridView.count(
          crossAxisCount: 7,
          children: children,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Increment',
        onPressed: () { print("hey"); },
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

}