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
              button: Directionality(
                textDirection: TextDirection.rtl,
                child: ElevatedButton.icon(
                    style: indigoFilledButton(),
                    onPressed: () {},
                    label: const Text('View'),
                    icon: const Icon(Icons.navigate_before_rounded)),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            MenuCard(
              title: "Schedule Deliveries",
              description:
                  'Schedule deliveries for today’s route, or for future deliveries',
              button: Directionality(
                textDirection: TextDirection.rtl,
                child: ElevatedButton.icon(
                    style: indigoFilledButton(),
                    onPressed: () {},
                    label: const Text('Schedule'),
                    icon: const Icon(Icons.navigate_before_rounded)),
              ),
            ),
          ],
        ));
  }
}
