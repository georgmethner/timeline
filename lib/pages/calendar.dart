import 'package:flutter/material.dart';

import '../components/day.dart';

class Calendar extends StatelessWidget {
  Calendar({super.key});

  final children = <Widget>[];
  final cur_date = DateTime.utc(2024, 1);



  @override
  Widget build(BuildContext context) {
    for (var i = 0; i < 35; i++) {
      DateTime date = DateTime.utc(cur_date.year, cur_date.month, i+1);
      children.add(Day(date: date, entries: [],));
    }

    return Scaffold(
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