class PrepaidCardModel {
  final int cardId;
  final String code;
  final double amount;
  final bool isUsed;
  final int? usedBy;
  final DateTime? usedAt;
  final DateTime expiresAt;

  PrepaidCardModel({
    required this.cardId,
    required this.code,
    required this.amount,
    this.isUsed = false,
    this.usedBy,
    this.usedAt,
    required this.expiresAt,
  });

  bool get isValid => !isUsed && expiresAt.isAfter(DateTime.now());

  factory PrepaidCardModel.fromJson(Map<String, dynamic> json) =>
      PrepaidCardModel(
        cardId: json['card_id'] as int,
        code: json['code'] as String,
        amount: (json['amount'] as num).toDouble(),
        isUsed: (json['is_used'] as bool?) ?? false,
        usedBy: json['used_by'] as int?,
        usedAt: json['used_at'] != null
            ? DateTime.parse(json['used_at'] as String)
            : null,
        expiresAt: DateTime.parse(json['expires_at'] as String),
      );

  Map<String, dynamic> toJson() => {
    'card_id': cardId,
    'code': code,
    'amount': amount,
    'is_used': isUsed,
    'used_by': usedBy,
    'used_at': usedAt?.toIso8601String(),
    'expires_at': expiresAt.toIso8601String(),
  };
}
