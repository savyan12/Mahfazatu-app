class WalletModel {
  final int walletId;
  final int userId;
  final double balance;
  final int points;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  WalletModel({
    required this.walletId,
    required this.userId,
    this.balance = 0.0,
    this.points = 0,
    this.status = 'active',
    required this.createdAt,
    required this.updatedAt,
  });

  bool get isActive => status == 'active';

  factory WalletModel.fromJson(Map<String, dynamic> json) => WalletModel(
    walletId: json['wallet_id'] as int,
    userId: json['user_id'] as int,
    balance: (json['balance'] as num?)?.toDouble() ?? 0.0,
    points: (json['points'] as int?) ?? 0,
    status: (json['status'] as String?) ?? 'active',
    createdAt: DateTime.parse(json['created_at'] as String),
    updatedAt: DateTime.parse(json['updated_at'] as String),
  );

  Map<String, dynamic> toJson() => {
    'wallet_id': walletId,
    'user_id': userId,
    'balance': balance,
    'points': points,
    'status': status,
    'created_at': createdAt.toIso8601String(),
    'updated_at': updatedAt.toIso8601String(),
  };
}
