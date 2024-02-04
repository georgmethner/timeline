import 'package:flutter/material.dart';

import 'entry.dart';

class Day extends StatelessWidget {
  const Day({super.key, required this.date, required this.entries});

  final DateTime date;
  final List<Entry> entries;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          //Information
          const Divider(
            height: 0,
            thickness: 1,
          ),
          Padding(padding: const EdgeInsets.only(left:5), child: Row(
            children: entries,
          )),

        ]));
  }
}
