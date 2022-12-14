import 'package:delivery_manager_app/assets/loading_spinner.dart';
import 'package:delivery_manager_app/classes/delivery.dart';
import 'package:delivery_manager_app/pages/delivery/delivery_form.dart';
import 'package:delivery_manager_app/themes/button_style.dart';
import 'package:delivery_manager_app/util/delivery_functions.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:table_calendar/table_calendar.dart';

class DeliveryView extends StatefulWidget {
  const DeliveryView({super.key, required this.isar});

  final Isar isar;

  @override
  State<DeliveryView> createState() => _DeliveryViewState();
}

class _DeliveryViewState extends State<DeliveryView> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  late Future<List<Delivery>> futureDeliveries;

  List<Delivery> deliveriesOnSelectedDate = [];

  Future<List<Delivery>> getDeliveries() async {
    DateTime date = DateTime.now();

    DateTime dateStripped = DateTime(date.year, date.month, date.day)
        .subtract(const Duration(days: 1));

    return widget.isar.deliverys
        .filter()
        .dateGreaterThan(dateStripped)
        .or()
        .recurranceIsNotNull()
        .findAll();
  }

  void addDelivery(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DeliveryFormScreen(isar: widget.isar),
      ),
    );
  }

  void editDelivery(BuildContext context, Delivery delivery) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DeliveryFormScreen(
          delivery: delivery,
          isar: widget.isar,
        ),
      ),
    );
  }

  void deleteDelivery(BuildContext context, Delivery delivery) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Delete delivery'),
        content: const Text('Are you sure? Deleting a delivery is permanent.'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              widget.isar.writeTxn(() async {
                await widget.isar.deliverys.delete(delivery.id!);
              });
              Navigator.pop(context, 'OK');
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
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

    Stream<void> deliveriesChanged = widget.isar.deliverys.watchLazy();
    deliveriesChanged.listen((value) {
      refreshDeliveryList();
    });

    _selectedDay = _focusedDay;
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
                  text: 'Loading deliveries...',
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

            deliveriesOnSelectedDate =
                getDeliveriesForDay(_focusedDay, allDeliveries);

            return SingleChildScrollView(
              child: Column(
                children: [
                  TableCalendar(
                    firstDay: DateTime.now(),
                    lastDay: DateTime.now().add(const Duration(days: 366)),
                    focusedDay: _focusedDay,
                    calendarFormat: _calendarFormat,
                    availableGestures: AvailableGestures.horizontalSwipe,
                    availableCalendarFormats: const {
                      CalendarFormat.month: 'Month'
                    },
                    calendarStyle: CalendarStyle(
                      // Weekend dates color (Sat & Sun Column)
                      weekendTextStyle: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary),
                      // highlighted color for today
                      todayDecoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        shape: BoxShape.circle,
                      ),
                      // highlighted color for selected day
                      selectedDecoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        shape: BoxShape.circle,
                      ),
                      markerDecoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.tertiary,
                        shape: BoxShape.circle,
                      ),
                    ),
                    selectedDayPredicate: (day) {
                      // Use `selectedDayPredicate` to determine which day is currently selected.
                      // If this returns true, then `day` will be marked as selected.

                      // Using `isSameDay` is recommended to disregard
                      // the time-part of compared DateTime objects.
                      return isSameDay(_selectedDay, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      if (!isSameDay(_selectedDay, selectedDay)) {
                        // Call `setState()` when updating the selected day
                        setState(() {
                          _selectedDay = selectedDay;
                          _focusedDay = focusedDay;
                          deliveriesOnSelectedDate =
                              getDeliveriesForDay(selectedDay, allDeliveries);
                        });
                      }
                    },
                    onFormatChanged: (format) {
                      if (_calendarFormat != format) {
                        // Call `setState()` when updating calendar format
                        setState(() {
                          _calendarFormat = format;
                        });
                      }
                    },
                    onPageChanged: (focusedDay) {
                      // No need to call `setState()` here
                      _focusedDay = focusedDay;
                    },
                    eventLoader: (day) {
                      return getDeliveriesForDay(day, allDeliveries);
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    width: 135,
                    child: TextButton(
                      style: filledButtonPrimary(context),
                      onPressed: () {
                        addDelivery(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: const [
                          SizedBox(),
                          Text('New Delivery'),
                          Icon(
                            Icons.add_rounded,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  (deliveriesOnSelectedDate.isEmpty)
                      ? const Center(
                          child: Text('No deliveries scheduled'),
                        )
                      : Column(
                          children: [
                            const Text('Scheduled Deliveries:'),
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              padding: const EdgeInsets.all(8),
                              itemCount: deliveriesOnSelectedDate.length,
                              itemBuilder: (context, index) {
                                Delivery delivery =
                                    deliveriesOnSelectedDate[index];

                                return Card(
                                  elevation: 0,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .surfaceVariant,
                                  child: ListTile(
                                    title: Text(
                                        delivery.customer.value?.name ?? ''),
                                    subtitle: Text(delivery.customer.value
                                            ?.getAddressShort() ??
                                        ''),
                                    trailing: Theme(
                                      data: Theme.of(context)
                                          .copyWith(useMaterial3: false),
                                      child: PopupMenuButton<String>(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        // Callback that sets the selected popup menu item.
                                        onSelected: (String option) {
                                          switch (option) {
                                            case 'Edit':
                                              editDelivery(context, delivery);
                                              break;
                                            case 'Delete':
                                              deleteDelivery(context, delivery);
                                              break;
                                            default:
                                              break;
                                          }
                                        },
                                        itemBuilder: (BuildContext context) =>
                                            <PopupMenuEntry<String>>[
                                          const PopupMenuItem<String>(
                                            value: 'Edit',
                                            child: Text('Edit'),
                                          ),
                                          const PopupMenuItem<String>(
                                            value: 'Delete',
                                            child: Text('Delete'),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
