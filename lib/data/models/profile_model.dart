class ProfileModel {
  final int userId;
  final String authUid;
  final String name;
  final String phoneNumber;
  final String userType;
  final DateTime createdAt;

  ProfileModel({
    required this.userId,
    required this.authUid,
    this.name = '',
    this.phoneNumber = '',
    this.userType = 'customer',
    required this.createdAt,
  });

  bool get isMerchant => userType == 'merchant';
  bool get isCustomer => userType == 'customer';

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      userId: json['user_id'] as int,
      authUid: json['auth_uid'] as String,
      name: (json['name'] as String?) ?? '',
      phoneNumber: (json['phone_number'] as String?) ?? '',
      userType: (json['user_type'] as String?) ?? 'customer',
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
    'user_id': userId,
    'auth_uid': authUid,
    'name': name,
    'phone_number': phoneNumber,
    'user_type': userType,
    'created_at': createdAt.toIso8601String(),
  };

  ProfileModel copyWith({String? name, String? phoneNumber}) => ProfileModel(
    userId: userId,
    authUid: authUid,
    name: name ?? this.name,
    phoneNumber: phoneNumber ?? this.phoneNumber,
    userType: userType,
    createdAt: createdAt,
  );
}
