import 'package:delivery_manager_app/assets/loading_spinner.dart';
import 'package:delivery_manager_app/classes/delivery_route.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DeliveryManager extends StatelessWidget {
  const DeliveryManager({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                child: const Text(
                  "Today's Route",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Card(
                child: FutureBuilder(
                    future: Hive.openBox<DeliveryRoute>('routes'),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState != ConnectionState.done) {
                        return Center(
                          child: loadingSpinner(
                            text: 'Loading route...',
                            alignment: MainAxisAlignment.center,
                          ),
                        );
                      }

                      // If an error occurred, display it.
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString(),
                              style: const TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold)),
                        );
                      }

                      return ValueListenableBuilder<Box>(
                        valueListenable:
                            Hive.box<DeliveryRoute>('routes').listenable(),
                        builder: (context, box, widget) {
                          if (box.values.isEmpty) {
                            return const Center(
                              child: Text('No routes found'),
                            );
                          } else {
                            return const Center(
                              child: Text('No routes found'),
                            );
                          }
                        },
                      );
                    }),
              ),
            ],
          )),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => {},
        label: const Text('Schedule Delivery'),
        icon: const Icon(Icons.edit_calendar),
      ),
    );
  }
}
