import 'package:flutter/material.dart';

class MenuCard extends StatelessWidget {
  const MenuCard({
    Key? key,
    required this.title,
    required this.description,
    required this.button,
  }) : super(key: key);

  final String title;
  final String description;
  final Widget button;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(description),
          const SizedBox(
            height: 8,
          ),
          Align(
              alignment: Alignment.centerRight,
              child: SizedBox(width: 125, child: button)),
        ],
      ),
    ));
  }
}
