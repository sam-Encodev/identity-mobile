import 'package:flutter/material.dart';

snackBar(BuildContext context, {message}) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
    message,
    style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
  )));
}
