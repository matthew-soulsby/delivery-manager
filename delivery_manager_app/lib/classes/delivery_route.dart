import 'item.dart';
import 'payment.dart';
import 'delivery.dart';
import 'package:hive/hive.dart';

part 'delivery_route.g.dart';

@HiveType(typeId: 4)
class DeliveryRoute extends HiveObject {
  @HiveField(0)
  DateTime date;

  @HiveField(1)
  HiveList<Delivery> deliveries;

  @HiveField(2)
  bool optimised;

  @HiveField(3)
  List<int> indexesOfCompleted;

  DeliveryRoute(
      {required this.date,
      required this.deliveries,
      required this.optimised,
      required this.indexesOfCompleted});
}
