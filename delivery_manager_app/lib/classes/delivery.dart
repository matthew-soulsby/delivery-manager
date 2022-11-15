import 'item.dart';
import 'payment.dart';
import 'customer.dart';
import 'package:hive/hive.dart';

part 'delivery.g.dart';

enum Recurrance { everyWeek, everySecondWeek, everyThirdWeek, everyFourthWeek }

@HiveType(typeId: 3)
class Delivery extends HiveObject {
  @HiveField(0)
  DateTime date;

  @HiveField(1)
  Recurrance? recurrance;

  @HiveField(2)
  List<Item>? itemsToDeliver;

  @HiveField(3)
  Payment? payment;

  @HiveField(4)
  HiveList<Customer> customer;

  Delivery(
      {required this.date,
      this.recurrance,
      this.itemsToDeliver,
      this.payment,
      required this.customer});
}
