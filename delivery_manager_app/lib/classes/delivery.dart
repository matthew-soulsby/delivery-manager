import 'package:isar/isar.dart';
import 'item.dart';
import 'payment.dart';
import 'customer.dart';

part 'delivery.g.dart';

enum Recurrance { everyWeek, everySecondWeek, everyThirdWeek, everyFourthWeek }

@collection
class Delivery {
  Id? id;

  @Index()
  DateTime? date;

  @Enumerated(EnumType.ordinal32)
  Recurrance? recurrance;

  List<Item> itemsToDeliver = [];

  Payment? payment;

  final customer = IsarLink<Customer>();
}
