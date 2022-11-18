import 'package:isar/isar.dart';

part 'item.g.dart';

@embedded
class Item {
  String? name;

  String? itemPLU;

  String? barcode;

  int? priceCents;
}
