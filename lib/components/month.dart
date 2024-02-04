import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:service_reddit_2/components/entry.dart';
import 'package:service_reddit_2/components/long_entry.dart';

import 'day.dart';

class Month extends StatelessWidget {
  Month({super.key, required this.date, required this.month_length});

  final DateTime date;
  final int month_length;

  @override
  Widget build(BuildContext context) {
    List<Widget> days = <Widget>[];

    for (int i = 0; i < month_length; i++) {
      DateTime day = DateTime(date.year, (date.month - 1 % 12) + 1, i + 1);
      List<Entry> entries = <Entry>[];
      entries.add(Entry(name: day.day.toString(), color: Theme.of(context).primaryColor));

      DateFormat formatter = DateFormat('yyyy-MM-dd');
      if (formatter.format(day) == formatter.format(DateTime.now())) {
        print(Colors.primaries[Random().nextInt(Colors.primaries.length)]);
        entries.add(Entry(
          name: "Heute",
          color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
        ));
        entries.add(Entry(
            name: "test1", color: Colors.primaries[Random().nextInt(Colors.primaries.length)]));
        entries.add(Entry(
            name: "test2", color: Colors.primaries[Random().nextInt(Colors.primaries.length)]));
      }

      days.add(Day(
        date: day,
        entries: entries,
      ));
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Divider(
                height: 0,
              ),
              Padding(
                  padding: const EdgeInsets.only(bottom: 2, left: 10, top: 10),
                  child: Text(
                      "${DateFormat.MMMM('de').format(DateTime(0, date.month))} ${date.year}")),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: days,
              ),
            ]),
        Expanded(child: LongEntry(from: DateTime.now(), to: DateTime.now(), name: "test")),
      ],
    );
  }
}
