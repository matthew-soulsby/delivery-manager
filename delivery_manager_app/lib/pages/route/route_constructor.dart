import 'package:delivery_manager_app/assets/loading_spinner.dart';
import 'package:delivery_manager_app/classes/delivery.dart';
import 'package:delivery_manager_app/pages/route/route_visualiser.dart';
import 'package:delivery_manager_app/themes/button_style.dart';
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

  void addToRoute(Delivery delivery) {
    setState(() {
      _deliveriesInRoute.add(delivery);
      _deliveriesNotInRoute = List.from(_deliveriesNotInRoute)
        ..remove(delivery);
    });
  }

  void removeFromRoute(Delivery delivery) {
    setState(() {
      _deliveriesNotInRoute.add(delivery);
      _deliveriesInRoute = List.from(_deliveriesInRoute)..remove(delivery);
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
        title: const Text("Today's Route"),
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

            if (_deliveriesInRoute.isEmpty && _deliveriesNotInRoute.isEmpty) {
              _deliveriesNotInRoute = getDeliveriesForDay(today, allDeliveries);
            }

            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Current Route'),
                        SizedBox(
                          width: 125,
                          child: TextButton(
                            style: filledButtonPrimary(context),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      RouteVisualiser(isar: widget.isar),
                                ),
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: const [
                                SizedBox(),
                                Text('Optimise'),
                                Icon(
                                  Icons.navigate_next_rounded,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  (_deliveriesInRoute.isEmpty)
                      ? const Padding(
                          padding: EdgeInsets.all(8),
                          child: Center(
                            child: Text(
                                "No deliveries in current route. Add deliveries to today's route from those scheduled below."),
                          ),
                        )
                      : ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(8),
                          itemCount: _deliveriesInRoute.length,
                          itemBuilder: (context, index) {
                            Delivery delivery = _deliveriesInRoute[index];
                            return Card(
                              elevation: 0,
                              color:
                                  Theme.of(context).colorScheme.surfaceVariant,
                              child: ListTile(
                                title:
                                    Text(delivery.customer.value?.name ?? ''),
                                subtitle: Text(delivery.customer.value
                                        ?.getAddressShort() ??
                                    ''),
                                trailing: Theme(
                                  data: Theme.of(context)
                                      .copyWith(useMaterial3: false),
                                  child: TextButton(
                                    child: const Icon(Icons.remove_rounded),
                                    onPressed: () {
                                      removeFromRoute(delivery);
                                    },
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                  const Padding(
                    padding: EdgeInsets.all(8),
                    child: Text('Scheduled Deliveries'),
                  ),
                  (_deliveriesNotInRoute.isEmpty)
                      ? const Center(
                          child: Text('No scheduled deliveries'),
                        )
                      : ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(8),
                          itemCount: _deliveriesNotInRoute.length,
                          itemBuilder: (context, index) {
                            Delivery delivery = _deliveriesNotInRoute[index];
                            return Card(
                              elevation: 0,
                              color:
                                  Theme.of(context).colorScheme.surfaceVariant,
                              child: ListTile(
                                title:
                                    Text(delivery.customer.value?.name ?? ''),
                                subtitle: Text(delivery.customer.value
                                        ?.getAddressShort() ??
                                    ''),
                                trailing: Theme(
                                  data: Theme.of(context)
                                      .copyWith(useMaterial3: false),
                                  child: TextButton(
                                    child: const Icon(Icons.add_rounded),
                                    onPressed: () {
                                      addToRoute(delivery);
                                    },
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
