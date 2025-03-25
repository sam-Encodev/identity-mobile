import 'package:forui/forui.dart';
import 'package:flutter/material.dart';
import 'package:identity/constants/text.dart';

void dialog(BuildContext context, response) {
  showAdaptiveDialog<void>(
    context: context,
    builder:
        (context) => FDialog(
          direction: Axis.horizontal,
          body: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(response),
          ),
          actions: [
            FilledButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(close),
            ),
          ],
        ),
  );
}