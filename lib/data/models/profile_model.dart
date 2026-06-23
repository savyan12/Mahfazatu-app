class ProfileModel {
  final String id;
  final String email;
  final String? phone;
  final String firstName;
  final String lastName;
  final String? gender;
  final String? avatarUrl;
  final double balance;
  final int rewardPoints;
  final DateTime createdAt;
  final DateTime updatedAt;

  ProfileModel({
    required this.id,
    required this.email,
    this.phone,
    this.firstName = '',
    this.lastName = '',
    this.gender,
    this.avatarUrl,
    this.balance = 0.0,
    this.rewardPoints = 0,
    required this.createdAt,
    required this.updatedAt,
  });

  String get fullName => '$firstName $lastName';

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String?,
      firstName: (json['first_name'] as String?) ?? '',
      lastName: (json['last_name'] as String?) ?? '',
      gender: json['gender'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      balance: (json['balance'] as num?)?.toDouble() ?? 0.0,
      rewardPoints: (json['reward_points'] as int?) ?? 0,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'phone': phone,
      'first_name': firstName,
      'last_name': lastName,
      'gender': gender,
      'avatar_url': avatarUrl,
      'balance': balance,
      'reward_points': rewardPoints,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  ProfileModel copyWith({
    String? firstName,
    String? lastName,
    String? gender,
    String? avatarUrl,
    double? balance,
    int? rewardPoints,
  }) {
    return ProfileModel(
      id: id,
      email: email,
      phone: phone,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      gender: gender ?? this.gender,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      balance: balance ?? this.balance,
      rewardPoints: rewardPoints ?? this.rewardPoints,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
