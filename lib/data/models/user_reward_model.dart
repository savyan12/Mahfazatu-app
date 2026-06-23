class UserRewardModel {
  final int userRewardId;
  final int userId;
  final int rewardId;
  final DateTime redeemedAt;
  final int pointsSpent;
  final String status;

  UserRewardModel({
    required this.userRewardId,
    required this.userId,
    required this.rewardId,
    required this.redeemedAt,
    required this.pointsSpent,
    this.status = 'pending',
  });

  factory UserRewardModel.fromJson(Map<String, dynamic> json) =>
      UserRewardModel(
        userRewardId: json['user_reward_id'] as int,
        userId: json['user_id'] as int,
        rewardId: json['reward_id'] as int,
        redeemedAt: DateTime.parse(json['redeemed_at'] as String),
        pointsSpent: (json['points_spent'] as num).toInt(),
        status: (json['status'] as String?) ?? 'pending',
      );

  Map<String, dynamic> toJson() => {
    'user_reward_id': userRewardId,
    'user_id': userId,
    'reward_id': rewardId,
    'redeemed_at': redeemedAt.toIso8601String(),
    'points_spent': pointsSpent,
    'status': status,
  };
}
