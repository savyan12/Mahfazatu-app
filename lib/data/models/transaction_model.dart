enum TransactionType { topup, transfer, payment, redeem }
enum TransactionStatus { pending, completed, failed }

class TransactionModel {
  final String id;
  final String userId;
  final TransactionType type;
  final double amount;
  final String currency;
  final TransactionStatus status;
  final String? description;
  final String? referenceId;
  final String? counterparty;
  final DateTime createdAt;

  TransactionModel({
    required this.id,
    required this.userId,
    required this.type,
    required this.amount,
    this.currency = 'LYD',
    this.status = TransactionStatus.completed,
    this.description,
    this.referenceId,
    this.counterparty,
    required this.createdAt,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      type: _parseType(json['type'] as String),
      amount: (json['amount'] as num).toDouble(),
      currency: (json['currency'] as String?) ?? 'LYD',
      status: _parseStatus(json['status'] as String? ?? 'completed'),
      description: json['description'] as String?,
      referenceId: json['reference_id'] as String?,
      counterparty: json['counterparty'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'type': type.name,
      'amount': amount,
      'currency': currency,
      'status': status.name,
      'description': description,
      'reference_id': referenceId,
      'counterparty': counterparty,
      'created_at': createdAt.toIso8601String(),
    };
  }

  static TransactionType _parseType(String value) {
    return TransactionType.values.firstWhere(
      (e) => e.name == value,
      orElse: () => TransactionType.payment,
    );
  }

  static TransactionStatus _parseStatus(String value) {
    return TransactionStatus.values.firstWhere(
      (e) => e.name == value,
      orElse: () => TransactionStatus.completed,
    );
  }

  String get formattedAmount {
    final prefix = type == TransactionType.topup ? '+' : '-';
    return '$prefix${amount.toStringAsFixed(2)} $currency';
  }

  bool get isCredit => type == TransactionType.topup;
}
