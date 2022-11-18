import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

class ReportManager extends StatelessWidget {
  const ReportManager({super.key, required this.isar});

  final Isar isar;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      alignment: Alignment.center,
      child: const Text('Report Manager'),
    );
  }
}
