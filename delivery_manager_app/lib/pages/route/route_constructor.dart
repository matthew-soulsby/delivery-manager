import 'package:delivery_manager_app/assets/loading_spinner.dart';
import 'package:delivery_manager_app/classes/delivery.dart';
import 'package:delivery_manager_app/util/delivery_functions.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

class RouteConstructor extends StatefulWidget {
  const RouteConstructor({super.key, required this.isar});

  final Isar isar;

  @override
  State<RouteConstructor> createState() => _RouteConstructorState();
}

class _RouteConstructorState extends State<RouteConstructor> {
  late Future<List<Delivery>> futureDeliveries;
  DateTime today =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  List<Delivery> _deliveriesNotInRoute = [];
  List<Delivery> _deliveriesInRoute = [];

  Future<List<Delivery>> getDeliveries() async {
    DateTime date = DateTime.now();

    DateTime dateStripped = DateTime(date.year, date.month, date.day);

    return widget.isar.deliverys
        .filter()
        .dateEqualTo(dateStripped)
        .or()
        .recurranceIsNotNull()
        .findAll();
  }

  void refreshDeliveryList() {
    if (!mounted) return;

    setState(() {
      futureDeliveries = getDeliveries();
    });
  }

  @override
  void initState() {
    super.initState();

    futureDeliveries = getDeliveries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Schedule Deliveries'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
        child: FutureBuilder(
          future: futureDeliveries,
          builder: (context, snapshot) {
            // If we're not done, then show the loading spinner.
            if (snapshot.connectionState != ConnectionState.done) {
              return Center(
                child: loadingSpinner(
                  text: "Loading today's deliveries...",
                  alignment: MainAxisAlignment.center,
                ),
              );
            }

            // If an error occurred, display it.
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  snapshot.error.toString(),
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }

            final allDeliveries = snapshot.requireData;

            _deliveriesNotInRoute = getDeliveriesForDay(today, allDeliveries);

            return SingleChildScrollView(
              child: Column(
                children: [],
              ),
            );
          },
        ),
      ),
    );
  }
}
