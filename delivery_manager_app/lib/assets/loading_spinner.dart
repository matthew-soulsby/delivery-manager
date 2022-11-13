import 'package:flutter/material.dart';

/// Loading spinner beside loading text layout.
Widget loadingSpinner({String text = 'Loading...', 
  MainAxisAlignment alignment = MainAxisAlignment.start}) {
  
  return Row(
    mainAxisAlignment: alignment,
    children: [
      const SizedBox(
        height: 24.0,
        width: 24.0,
        child: CircularProgressIndicator(),
      ),
      const SizedBox(width: 24.0),
      Text(text)
    ]
  );
}