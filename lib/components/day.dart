import 'package:flutter/material.dart';

class JobEntry extends StatelessWidget {
  JobEntry({super.key, required this.date});

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('MyButton was tapped!');
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
        padding: const EdgeInsets.only(top: 12, left: 15, right: 12, bottom: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(width: 1.5, color: Theme.of(context).colorScheme.outline),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //Information
              Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                Text(date.day.toString(),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ]),
            ]),
      ),
    );
  }
}
