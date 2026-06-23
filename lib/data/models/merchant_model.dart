enum MerchantCategory { cafe, shopping, restaurant, services }

class MerchantModel {
  final String id;
  final String name;
  final MerchantCategory category;
  final String? description;
  final double latitude;
  final double longitude;
  final double rating;
  final String iconName;
  final String accentColor;
  final bool isActive;
  final DateTime createdAt;

  MerchantModel({
    required this.id,
    required this.name,
    required this.category,
    this.description,
    required this.latitude,
    required this.longitude,
    this.rating = 0,
    this.iconName = 'store',
    this.accentColor = '#2EBD8A',
    this.isActive = true,
    required this.createdAt,
  });

  factory MerchantModel.fromJson(Map<String, dynamic> json) {
    return MerchantModel(
      id: json['id'] as String,
      name: json['name'] as String,
      category: _parseCategory(json['category'] as String),
      description: json['description'] as String?,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      rating: (json['rating'] as num?)?.toDouble() ?? 0,
      iconName: (json['icon_name'] as String?) ?? 'store',
      accentColor: (json['accent_color'] as String?) ?? '#2EBD8A',
      isActive: (json['is_active'] as bool?) ?? true,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category.name,
      'description': description,
      'latitude': latitude,
      'longitude': longitude,
      'rating': rating,
      'icon_name': iconName,
      'accent_color': accentColor,
      'is_active': isActive,
      'created_at': createdAt.toIso8601String(),
    };
  }

  static MerchantCategory _parseCategory(String value) {
    return MerchantCategory.values.firstWhere(
      (e) => e.name == value,
      orElse: () => MerchantCategory.services,
    );
  }
}
