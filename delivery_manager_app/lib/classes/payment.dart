import 'package:hive/hive.dart';

part 'payment.g.dart';

enum PaymentType { cash, card, account }

@HiveType(typeId: 2)
class Payment extends HiveObject {
  @HiveField(0)
  PaymentType paymentType;

  @HiveField(1)
  int amountCents;

  Payment({required this.paymentType, required this.amountCents});
}
