import 'package:delivery_manager_app/classes/item.dart';

import 'package:intl/intl.dart';

int getTotal(List<Item> itemsToDeliver) {
  int total = 0;

  for (var item in itemsToDeliver) {
    total += item.priceCents ?? 0;
  }

  return total;
}

String formatPrice(int priceCents) {
  return NumberFormat.simpleCurrency(
    decimalDigits: 2,
  ).format(priceCents / 100);
}

int parsePrice(String formattedPrice) {
  String unformattedPrice = formattedPrice.replaceAll(RegExp(r"[^0-9]"), '');
  return int.parse(unformattedPrice);
}
