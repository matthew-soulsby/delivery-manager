import 'package:delivery_manager_app/classes/delivery.dart';
import 'package:table_calendar/table_calendar.dart';

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

bool isDeliveryForDay(Delivery delivery, DateTime day) {
  if (day.isBefore(delivery.date!)) {
    return false;
  }

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

int daysBetween(DateTime from, DateTime to) {
  from = DateTime(from.year, from.month, from.day);
  to = DateTime(to.year, to.month, to.day);
  return (to.difference(from).inHours / 24).round();
}
