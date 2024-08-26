import 'dart:ui';

class CreditCardEntity {
  final String cardNumber;
  final String cardExpiry;
  final String cardHolderName;
  final String cvv;
  final String bankName;
  final String cardType;
  final Color color;

  CreditCardEntity({
    required this.cardNumber,
    required this.cardExpiry,
    required this.cardHolderName,
    required this.cvv,
    this.bankName = 'BanColombia',
    required this.cardType,
    required this.color,
  });
}
