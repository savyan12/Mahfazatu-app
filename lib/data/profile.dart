class Profile {
  final String name;
  final String email;
  final String phone;
  final double balance;
  final int points;

  const Profile({
    required this.name,
    required this.email,
    required this.phone,
    required this.balance,
    required this.points,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      balance: (json['balance'] as num).toDouble(),
      points: (json['points'] as num).toInt(),
    );
  }
}
