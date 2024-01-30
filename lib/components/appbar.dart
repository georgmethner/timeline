import 'package:flutter/material.dart';

class Appbar extends AppBar {
  Appbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
    backgroundColor: Theme.of(context).colorScheme.primary,
    title: Text("Homepage"),

    );

  }
}
