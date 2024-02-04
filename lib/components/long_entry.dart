import 'package:flutter/material.dart';

class LongEntry extends StatelessWidget {
  const LongEntry({super.key, required this.from, required this.to, required this.name});

  final DateTime from, to;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
      ),
      color: Theme.of(context).colorScheme.onPrimary,
      margin: EdgeInsets.zero,
      child: RotatedBox(
          quarterTurns: 45,
          child: Text(
            name,
          )),
    );
  }
}
