import 'package:flutter/material.dart';

ButtonStyle indigoFilledButton() {
  return ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(Colors.indigo),
    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
    overlayColor: MaterialStateProperty.all<Color>(Color.fromARGB(66, 0, 0, 0)),
  );
}
