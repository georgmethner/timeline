import 'package:flutter/material.dart';


class Entry extends StatelessWidget {
  const Entry({super.key, required this.name, required this.color});

  final String name;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        color: color,
        margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 1),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 0),
          child: Text(
            name,
          ),
        ),
      ),
      const Text(","),

    ]);
  }
}
