import 'package:delivery_manager_app/assets/button_style.dart';
import 'package:delivery_manager_app/assets/loading_spinner.dart';
import 'package:delivery_manager_app/assets/menu_card.dart';
import 'package:delivery_manager_app/classes/delivery_route.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DeliveryManager extends StatelessWidget {
  const DeliveryManager({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MenuCard(
            title: "Today's Deliveries",
            description: 'View, optimise, and start your delivery run',
            button: ElevatedButton(
              style: indigoFilledButton(),
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
                'Schedule deliveries for today’s route, or for future deliveries',
            button: ElevatedButton(
              style: indigoFilledButton(),
              onPressed: () {},
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
