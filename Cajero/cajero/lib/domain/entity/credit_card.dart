import 'dart:ui';

class CreditCardEntity {
  final String cardNumber;
  final String cardExpiry;
  final String cardHolderName;
  final String cvv;
  final String bankName;
  final Color color;

  static const String bdName = 'credit-card';

  CreditCardEntity({
    required this.cardNumber,
    required this.cardExpiry,
    required this.cardHolderName,
    required this.cvv,
    this.bankName = 'BanColombia',
    required this.color,
  });
  // Convert CreditCardEntity to JSON
  Map<String, dynamic> toJson() => {
        'cardNumber': cardNumber,
        'cardExpiry': cardExpiry,
        'cardHolderName': cardHolderName,
        'cvv': cvv,
        'bankName': bankName,
        'color': color.value
            .toRadixString(16), // Convert Color to hexadecimal string
      };

  // Create CreditCardEntity from JSON
  factory CreditCardEntity.fromJson(Map<String, dynamic> json) =>
      CreditCardEntity(
        cardNumber: json['cardNumber'],
        cardExpiry: json['cardExpiry'],
        cardHolderName: json['cardHolderName'],
        cvv: json['cvv'],
        bankName: json['bankName'],
        color: Color(int.parse(json['color'],
            radix: 16)), // Convert from hexadecimal string to Color
      );
}
