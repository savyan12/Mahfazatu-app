enum TransactionType { transfer, payment }
enum PaymentMethod { nfc, qr, direct }
enum TransactionStatus { pending, completed, failed }

class TransactionModel {
  final int transactionId;
  final int senderWalletId;
  final int receiverWalletId;
  final TransactionType transactionType;
  final double amount;
  final PaymentMethod paymentMethod;
  final TransactionStatus status;
  final int? branchId;
  final String? notes;
  final DateTime transactionDate;

  TransactionModel({
    required this.transactionId,
    required this.senderWalletId,
    required this.receiverWalletId,
    required this.transactionType,
    required this.amount,
    this.paymentMethod = PaymentMethod.direct,
    this.status = TransactionStatus.pending,
    this.branchId,
    this.notes,
    required this.transactionDate,
  });

  bool get isCompleted => status == TransactionStatus.completed;
  bool get isPayment => transactionType == TransactionType.payment;
  bool get isTransfer => transactionType == TransactionType.transfer;

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
        transactionId: json['transaction_id'] as int,
        senderWalletId: json['sender_wallet_id'] as int,
        receiverWalletId: json['receiver_wallet_id'] as int,
        transactionType: _parseType(json['transaction_type'] as String),
        amount: (json['amount'] as num).toDouble(),
        paymentMethod:
            _parsePayment(json['payment_method'] as String? ?? 'direct'),
        status: _parseStatus(json['status'] as String? ?? 'pending'),
        branchId: json['branch_id'] as int?,
        notes: json['notes'] as String?,
        transactionDate: DateTime.parse(json['transaction_date'] as String),
      );

  Map<String, dynamic> toJson() => {
    'transaction_id': transactionId,
    'sender_wallet_id': senderWalletId,
    'receiver_wallet_id': receiverWalletId,
    'transaction_type': transactionType.name,
    'amount': amount,
    'payment_method': paymentMethod.name,
    'status': status.name,
    'branch_id': branchId,
    'notes': notes,
    'transaction_date': transactionDate.toIso8601String(),
  };

  static TransactionType _parseType(String v) =>
      TransactionType.values.firstWhere((e) => e.name == v,
          orElse: () => TransactionType.payment);

  static PaymentMethod _parsePayment(String v) =>
      PaymentMethod.values.firstWhere((e) => e.name == v,
          orElse: () => PaymentMethod.direct);

  static TransactionStatus _parseStatus(String v) =>
      TransactionStatus.values.firstWhere((e) => e.name == v,
          orElse: () => TransactionStatus.pending);
}
