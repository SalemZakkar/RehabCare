import 'package:flutter/material.dart';

void myCustomShowSnackBarText(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.fixed,
    ),
  );
}
