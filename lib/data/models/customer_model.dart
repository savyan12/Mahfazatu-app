class CustomerModel {
  final int userId;
  CustomerModel({required this.userId});
  factory CustomerModel.fromJson(Map<String, dynamic> json) =>
      CustomerModel(userId: json['user_id'] as int);
  Map<String, dynamic> toJson() => {'user_id': userId};
}
