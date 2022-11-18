import 'package:isar/isar.dart';

part 'customer.g.dart';

@collection
class Customer {
  Id? id;

  String? name;

  String? addressLine1;

  String? addressLine2;

  String? suburb;

  String? stateTerritory;

  int? postcode;

  String getAddressShort() {
    String address = ((addressLine2 == null)
        ? '$addressLine1, $suburb, $stateTerritory $postcode'
        : '$addressLine2, $addressLine1, $suburb, $stateTerritory $postcode');

    return address;
  }
}
