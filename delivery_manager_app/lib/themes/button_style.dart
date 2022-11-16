import 'package:flutter/material.dart';

List<Color> getPrimaryColors(BuildContext context) {
  return [
    Theme.of(context).colorScheme.primary,
    Theme.of(context).colorScheme.onPrimary
  ];
}

List<Color> getSecondaryColors(BuildContext context) {
  return [
    Theme.of(context).colorScheme.secondary,
    Theme.of(context).colorScheme.onSecondary
  ];
}

List<Color> getTertiaryColors(BuildContext context) {
  return [
    Theme.of(context).colorScheme.tertiary,
    Theme.of(context).colorScheme.onTertiary
  ];
}

ButtonStyle filledButtonPrimary(BuildContext context) {
  List<Color> colors = getPrimaryColors(context);

  return ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(colors[0]),
    foregroundColor: MaterialStateProperty.all<Color>(colors[1]),
  );
}

ButtonStyle filledButtonSecondary(BuildContext context) {
  List<Color> colors = getSecondaryColors(context);

  return ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(colors[0]),
    foregroundColor: MaterialStateProperty.all<Color>(colors[1]),
  );
}

ButtonStyle filledButtonTertiary(BuildContext context) {
  List<Color> colors = getTertiaryColors(context);

  return ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(colors[0]),
    foregroundColor: MaterialStateProperty.all<Color>(colors[1]),
  );
}
