import 'package:isar/isar.dart';

part 'payment.g.dart';

enum PaymentType { cash, card, account }

@embedded
class Payment {
  @Enumerated(EnumType.ordinal32)
  PaymentType? paymentType;

  int? amountCents;
}
