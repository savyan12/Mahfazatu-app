import 'package:flutter/material.dart';

class Transaction {
  final int id;
  final String title;
  final String description;
  final double amount;
  final DateTime date;
  final String time;
  final String type;

  const Transaction({
    required this.id,
    required this.title,
    required this.description,
    required this.amount,
    required this.date,
    required this.time,
    required this.type,
  });

  bool get isIncome => type == 'income';

  IconData get icon => isIncome
      ? Icons.swap_horiz_rounded
      : Icons.shopping_cart_outlined;

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      amount: (json['amount'] as num).toDouble(),
      date: DateTime.parse(json['date'] as String),
      time: json['time'] as String,
      type: json['type'] as String,
    );
  }
}
