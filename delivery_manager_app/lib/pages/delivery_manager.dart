import 'package:delivery_manager_app/pages/delivery/delivery_view.dart';
import 'package:delivery_manager_app/themes/button_style.dart';
import 'package:delivery_manager_app/assets/loading_spinner.dart';
import 'package:delivery_manager_app/assets/menu_card.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

class DeliveryManager extends StatelessWidget {
  const DeliveryManager({super.key, required this.isar});

  final Isar isar;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MenuCard(
            title: "Today's Route",
            description: 'View, optimise, and start your delivery run',
            button: TextButton(
              style: filledButtonPrimary(context),
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: const [
                  SizedBox(),
                  Text('View'),
                  Icon(
                    Icons.navigate_next_rounded,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          MenuCard(
            title: "Schedule Deliveries",
            description:
                "Schedule deliveries for today's route, or for future deliveries",
            button: TextButton(
              style: filledButtonPrimary(context),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DeliveryView(isar: isar),
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: const [
                  SizedBox(),
                  Text('Schedule'),
                  Icon(
                    Icons.navigate_next_rounded,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
