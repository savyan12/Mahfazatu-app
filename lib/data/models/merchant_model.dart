class MerchantModel {
  final int userId;
  final String merchantCode;
  final String serviceType;
  final double latitude;
  final double longitude;
  final String? name;

  MerchantModel({
    required this.userId,
    required this.merchantCode,
    required this.serviceType,
    this.latitude = 0,
    this.longitude = 0,
    this.name,
  });

  factory MerchantModel.fromJson(Map<String, dynamic> json) {
    String? name;
    if (json['profiles'] is Map<String, dynamic>) {
      name = (json['profiles'] as Map<String, dynamic>)['name'] as String?;
    }

    return MerchantModel(
      userId: json['user_id'] as int,
      merchantCode: json['merchant_code'] as String,
      serviceType: json['service_type'] as String,
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0,
      name: name,
    );
  }

  Map<String, dynamic> toJson() => {
    'user_id': userId,
    'merchant_code': merchantCode,
    'service_type': serviceType,
    'latitude': latitude,
    'longitude': longitude,
  };
}
