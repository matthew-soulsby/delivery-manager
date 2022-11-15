import 'item.dart';
import 'payment.dart';
import 'delivery.dart';
import 'package:hive/hive.dart';

part 'route.g.dart';

@HiveType(typeId: 3)
class Route extends HiveObject {
  @HiveField(0)
  DateTime date;

  @HiveField(1)
  HiveList<Delivery> deliveries;

  @HiveField(2)
  bool optimised;

  @HiveField(3)
  List<int> indexesOfCompleted;

  Route(
      {required this.date,
      required this.deliveries,
      required this.optimised,
      required this.indexesOfCompleted});
}
