class BranchModel {
  final int branchId;
  final int merchantId;
  final String branchName;
  final String qrCode;
  final String? locationUrl;
  final double latitude;
  final double longitude;
  final bool isActive;

  BranchModel({
    required this.branchId,
    required this.merchantId,
    required this.branchName,
    required this.qrCode,
    this.locationUrl,
    this.latitude = 0,
    this.longitude = 0,
    this.isActive = true,
  });

  factory BranchModel.fromJson(Map<String, dynamic> json) => BranchModel(
    branchId: json['branch_id'] as int,
    merchantId: json['merchant_id'] as int,
    branchName: json['branch_name'] as String,
    qrCode: json['qr_code'] as String,
    locationUrl: json['location_url'] as String?,
    latitude: (json['latitude'] as num?)?.toDouble() ?? 0,
    longitude: (json['longitude'] as num?)?.toDouble() ?? 0,
    isActive: (json['is_active'] as bool?) ?? true,
  );

  Map<String, dynamic> toJson() => {
    'branch_id': branchId,
    'merchant_id': merchantId,
    'branch_name': branchName,
    'qr_code': qrCode,
    'location_url': locationUrl,
    'latitude': latitude,
    'longitude': longitude,
    'is_active': isActive,
  };
}
