import 'package:hive/hive.dart';

part 'item.g.dart';

@HiveType(typeId: 1)
class Item extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String? PLU;

  @HiveField(2)
  String? barcode;

  @HiveField(3)
  int priceCents;

  Item({required this.name, this.PLU, this.barcode, required this.priceCents});
}
