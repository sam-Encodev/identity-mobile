import 'package:forui/forui.dart';
import 'package:flutter/material.dart';

const iconsSize = 38.0;
const buttonRadius = 15.0;
const inputBorderRadius = 30.0;
const pagePadding = EdgeInsets.fromLTRB(15, 0, 15, 15);
const icons = [
  Icon(Icons.phone_android_outlined, size: iconsSize),
  Icon(Icons.wb_sunny_outlined, size: iconsSize),
  Icon(Icons.dark_mode_outlined, size: iconsSize),
];

fDialogStyles(BuildContext context) {
  return FDialogStyle(
    horizontalStyle: FDialogContentStyle(
      titleTextStyle: TextStyle(),
      bodyTextStyle: TextStyle(color: Theme.of(context).colorScheme.outline),
      padding: EdgeInsets.all(20.0),
      actionSpacing:  double.minPositive,
    ),
    verticalStyle: FDialogContentStyle(
      titleTextStyle: TextStyle(),
      bodyTextStyle: TextStyle(color: Theme.of(context).colorScheme.outline),
      padding: EdgeInsets.all(20.0),
      actionSpacing:  double.minPositive,
    ),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.onInverseSurface,
      borderRadius: BorderRadius.circular(15),
    ),
  );
}