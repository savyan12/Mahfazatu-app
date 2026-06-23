enum CardType { visa, mastercard, amex }

class CardModel {
  final String id;
  final String userId;
  final String cardNumber;
  final String cardholderName;
  final String expiryDate;
  final String? cvv;
  final CardType cardType;
  final bool isActive;
  final DateTime createdAt;

  CardModel({
    required this.id,
    required this.userId,
    required this.cardNumber,
    required this.cardholderName,
    required this.expiryDate,
    this.cvv,
    this.cardType = CardType.visa,
    this.isActive = true,
    required this.createdAt,
  });

  String get maskedNumber => cardNumber.length >= 4
      ? '**** ${cardNumber.substring(cardNumber.length - 4)}'
      : cardNumber;

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      cardNumber: json['card_number'] as String,
      cardholderName: json['cardholder_name'] as String,
      expiryDate: json['expiry_date'] as String,
      cvv: json['cvv'] as String?,
      cardType: _parseType(json['card_type'] as String? ?? 'visa'),
      isActive: (json['is_active'] as bool?) ?? true,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'card_number': cardNumber,
      'cardholder_name': cardholderName,
      'expiry_date': expiryDate,
      'cvv': cvv,
      'card_type': cardType.name,
      'is_active': isActive,
      'created_at': createdAt.toIso8601String(),
    };
  }

  static CardType _parseType(String value) {
    return CardType.values.firstWhere(
      (e) => e.name == value,
      orElse: () => CardType.visa,
    );
  }
}
