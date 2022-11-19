import 'dart:collection';

import 'package:delivery_manager_app/assets/loading_spinner.dart';
import 'package:delivery_manager_app/classes/delivery.dart';
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

  late Future<List<Delivery>> deliveryFuture;

  Future<List<Delivery>> getDeliveries() async {
    DateTime date = DateTime.now();

    DateTime dateStripped = DateTime(date.year, date.month, date.day)
        .subtract(const Duration(days: 1));

    return widget.isar.deliverys
        .where()
        .dateGreaterThan(dateStripped)
        .findAll();
  }

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  bool isDeliveryForDay(Delivery delivery, DateTime day) {
    if (isSameDay(delivery.date, day)) {
      return true;
    }

    if (delivery.recurrance != null) {
      int differenceDays = daysBetween(day, delivery.date!);

      switch (delivery.recurrance) {
        case Recurrance.everyWeek:
          if (differenceDays % 7 == 0) {
            return true;
          }
          break;
        case Recurrance.everySecondWeek:
          if (differenceDays % 14 == 0) {
            return true;
          }
          break;
        case Recurrance.everyThirdWeek:
          if (differenceDays % 21 == 0) {
            return true;
          }
          break;
        case Recurrance.everyFourthWeek:
          if (differenceDays % 28 == 0) {
            return true;
          }
          break;
        default:
          break;
      }
    }

    return false;
  }

  List<Delivery> getDeliveriesForDay(
      DateTime selectedDay, List<Delivery> allDeliveries) {
    List<Delivery> deliveriesForDay = [];

    for (var delivery in allDeliveries) {
      if (isDeliveryForDay(delivery, selectedDay)) {
        deliveriesForDay.add(delivery);
      }
    }

    return deliveriesForDay;
  }

  @override
  void initState() {
    super.initState();

    deliveryFuture = getDeliveries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Schedule Deliveries'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: FutureBuilder(
          future: deliveryFuture,
          builder: (context, snapshot) {
            // If we're not done, then show the loading spinner.
            if (snapshot.connectionState != ConnectionState.done) {
              return Center(
                child: loadingSpinner(
                  text: 'Loading appointments...',
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

            return TableCalendar(
              firstDay: DateTime.now(),
              lastDay: DateTime.now().add(const Duration(days: 365)),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
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
            );
          },
        ),
      ),
    );
  }
}
