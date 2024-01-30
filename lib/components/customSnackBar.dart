import 'package:flutter/material.dart';

class CustomSnackBar {
  final String message;

  const CustomSnackBar({
    required this.message,
  });

  static show(
    BuildContext context,
    String message,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(
          child: Text(message),
        ),
        duration: new Duration(seconds: 1),
        width: 300,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
