class OfferModel {
  final String id;
  final String merchantId;
  final String title;
  final String? description;
  final String? badge;
  final String discountText;
  final int pointsRequired;
  final bool isActive;
  final DateTime createdAt;

  OfferModel({
    required this.id,
    required this.merchantId,
    required this.title,
    this.description,
    this.badge,
    required this.discountText,
    required this.pointsRequired,
    this.isActive = true,
    required this.createdAt,
  });

  factory OfferModel.fromJson(Map<String, dynamic> json) {
    return OfferModel(
      id: json['id'] as String,
      merchantId: json['merchant_id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      badge: json['badge'] as String?,
      discountText: json['discount_text'] as String,
      pointsRequired: (json['points_required'] as num).toInt(),
      isActive: (json['is_active'] as bool?) ?? true,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'merchant_id': merchantId,
      'title': title,
      'description': description,
      'badge': badge,
      'discount_text': discountText,
      'points_required': pointsRequired,
      'is_active': isActive,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
