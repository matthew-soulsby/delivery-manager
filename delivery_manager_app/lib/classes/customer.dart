import 'package:hive/hive.dart';

part 'customer.g.dart';

@HiveType(typeId: 0)
class Customer extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String addressLine1;

  @HiveField(2)
  String? addressLine2;

  @HiveField(3)
  String suburb;

  @HiveField(4)
  String stateTerritory;

  @HiveField(5)
  int postcode;

  Customer(
      {required this.name,
      required this.addressLine1,
      this.addressLine2,
      required this.suburb,
      required this.stateTerritory,
      required this.postcode});

  String getAddressShort() {
    String address = ((addressLine2 == null)
        ? '$addressLine1, $suburb, $stateTerritory $postcode'
        : '$addressLine2, $addressLine1, $suburb, $stateTerritory $postcode');

    return address;
  }
}
