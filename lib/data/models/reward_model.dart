class RewardModel {
  final int rewardId;
  final int merchantId;
  final String rewardType;
  final int requiredPoints;
  final String? description;
  final String? discountText;
  final bool isActive;

  RewardModel({
    required this.rewardId,
    required this.merchantId,
    required this.rewardType,
    required this.requiredPoints,
    this.description,
    this.discountText,
    this.isActive = true,
  });

  bool get isDiscount => rewardType == 'discount';
  bool get isPrize => rewardType == 'prize';

  factory RewardModel.fromJson(Map<String, dynamic> json) => RewardModel(
    rewardId: json['reward_id'] as int,
    merchantId: json['merchant_id'] as int,
    rewardType: json['reward_type'] as String,
    requiredPoints: (json['required_points'] as num).toInt(),
    description: json['description'] as String?,
    discountText: json['discount_text'] as String?,
    isActive: (json['is_active'] as bool?) ?? true,
  );

  Map<String, dynamic> toJson() => {
    'reward_id': rewardId,
    'merchant_id': merchantId,
    'reward_type': rewardType,
    'required_points': requiredPoints,
    'description': description,
    'discount_text': discountText,
    'is_active': isActive,
  };
}
