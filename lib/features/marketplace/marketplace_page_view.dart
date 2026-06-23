import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../../core/theme/app_colors.dart';
import '../../data/models/merchant_model.dart';
import '../../providers/merchant_provider.dart';
import 'marketplace_widgets.dart';

class MarketplacePageView extends ConsumerStatefulWidget {
  const MarketplacePageView({super.key});

  static const routeName = '/marketplace';

  @override
  ConsumerState<MarketplacePageView> createState() =>
      _MarketplacePageViewState();
}

class _MarketplacePageViewState extends ConsumerState<MarketplacePageView> {
  static const LatLng _tripoliFallback = LatLng(32.8872, 13.1913);
  late final MapController _mapController;
  LatLng _center = _tripoliFallback;
  bool _loadingLocation = true;
  String _locationLabel = 'ليبيا - طرابلس';
  String _locationStatus = 'جارٍ تحديد الموقع الحالي...';
  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _loadCurrentLocation();
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  Future<void> _loadCurrentLocation() async {
    try {
      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        if (!mounted) return;
        setState(() {
          _center = _tripoliFallback;
          _loadingLocation = false;
          _locationLabel = 'ليبيا - طرابلس';
          _locationStatus = 'تعذر الوصول للموقع، تم عرض طرابلس كخيار افتراضي.';
        });
        return;
      }

      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );

      if (!mounted) return;
      final loc = LatLng(position.latitude, position.longitude);
      setState(() {
        _center = loc;
        _loadingLocation = false;
        _locationLabel = 'الموقع الحالي';
        _locationStatus = 'تم تحديد موقعك الحالي على الخريطة.';
      });
      _mapController.move(loc, 14.5);
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _center = _tripoliFallback;
        _loadingLocation = false;
        _locationLabel = 'ليبيا - طرابلس';
        _locationStatus = 'تعذر الوصول للموقع، تم عرض طرابلس كخيار افتراضي.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final merchantsAsync = _selectedCategory == null
        ? ref.watch(merchantsProvider)
        : ref.watch(merchantsByCategoryProvider(_selectedCategory!));

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(18, 18, 18, 124),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.card.withValues(alpha: 0.95),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.cardBorder),
                    ),
                    child: const Icon(
                      Icons.notifications_none_rounded,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    'المتاجر القريبة',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                _locationLabel,
                textAlign: TextAlign.right,
                style: const TextStyle(
                  color: AppColors.mutedText,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                _locationStatus,
                textAlign: TextAlign.right,
                style: const TextStyle(
                  color: AppColors.mutedText,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                height: 48,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: AppColors.card.withValues(alpha: 0.82),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.cardBorder),
                ),
                child: const Row(
                  textDirection: TextDirection.ltr,
                  children: [
                    Icon(Icons.search_rounded, color: Colors.white),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'ابحث عن متجر أو خدمة',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: AppColors.mutedText,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              Container(
                height: 210,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: AppColors.cardBorder),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: FlutterMap(
                    mapController: _mapController,
                    options: MapOptions(
                      initialCenter: _tripoliFallback,
                      initialZoom: 13.2,
                      interactionOptions: const InteractionOptions(
                        flags: InteractiveFlag.all,
                      ),
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.example.mahfazati_app',
                      ),
                      MarkerLayer(
                        markers: [
                          Marker(
                            point: _center,
                            width: 40,
                            height: 40,
                            child: _loadingLocation
                                ? const MerchantMapPin(
                                    icon: Icons.location_searching_rounded,
                                    accent: AppColors.sky,
                                  )
                                : const MerchantMapPin(
                                    icon: Icons.my_location_rounded,
                                    accent: AppColors.sky,
                                  ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Row(
                textDirection: TextDirection.ltr,
                children: [
                  Expanded(
                    child: MarketplaceCategoryTile(
                      label: 'الكل',
                      icon: Icons.grid_view_rounded,
                      active: _selectedCategory == null,
                      onTap: () => setState(() => _selectedCategory = null),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: MarketplaceCategoryTile(
                      label: 'تسوق',
                      icon: Icons.shopping_bag_outlined,
                      active: _selectedCategory == 'shopping',
                      onTap: () =>
                          setState(() => _selectedCategory = 'shopping'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: MarketplaceCategoryTile(
                      label: 'مطاعم',
                      icon: Icons.restaurant_outlined,
                      active: _selectedCategory == 'restaurant',
                      onTap: () =>
                          setState(() => _selectedCategory = 'restaurant'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: MarketplaceCategoryTile(
                      label: 'خدمات',
                      icon: Icons.work_outline_rounded,
                      active: _selectedCategory == 'services',
                      onTap: () =>
                          setState(() => _selectedCategory = 'services'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              const Text(
                'المتاجر القريبة',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 23,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 12),
              merchantsAsync.when(
                data: (merchants) =>
                    _buildMerchantList(merchants),
                loading: () => const Center(
                  child: Padding(
                    padding: EdgeInsets.all(32),
                    child: CircularProgressIndicator(),
                  ),
                ),
                error: (_, _) => const Padding(
                  padding: EdgeInsets.all(32),
                  child: Text(
                    'حدث خطأ في تحميل المتاجر',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: AppColors.danger),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Container(
                height: 44,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.card.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.cardBorder),
                ),
                child: const Text(
                  'عرض المزيد',
                  style: TextStyle(
                    color: AppColors.mutedText,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMerchantList(List<MerchantModel> merchants) {
    if (merchants.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(24),
        child: Text(
          'لا توجد متاجر متاحة',
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.mutedText),
        ),
      );
    }

    return Column(
      children: merchants.map((m) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: MarketplaceStoreCard(
            name: m.name,
            category: _categoryName(m.category),
            rating: m.rating.toStringAsFixed(1),
            distance:
                '${_distanceTo(m.latitude, m.longitude).toStringAsFixed(1)} كم',
            icon: _iconFromString(m.iconName),
            accent: _colorFromHex(m.accentColor),
          ),
        );
      }).toList(),
    );
  }

  String _categoryName(MerchantCategory cat) {
    switch (cat) {
      case MerchantCategory.cafe:
        return 'مقهى';
      case MerchantCategory.shopping:
        return 'تسوق';
      case MerchantCategory.restaurant:
        return 'مطعم';
      case MerchantCategory.services:
        return 'خدمات';
    }
  }

  IconData _iconFromString(String name) {
    switch (name) {
      case 'local_cafe':
        return Icons.local_cafe_outlined;
      case 'shopping_cart':
        return Icons.shopping_cart_outlined;
      case 'restaurant':
        return Icons.restaurant_outlined;
      case 'local_hospital':
        return Icons.local_hospital_outlined;
      case 'devices':
        return Icons.devices_outlined;
      case 'nightlight':
        return Icons.nightlight_outlined;
      default:
        return Icons.store_outlined;
    }
  }

  Color _colorFromHex(String hex) {
    hex = hex.replaceAll('#', '');
    return Color(int.parse('FF$hex', radix: 16));
  }

  double _distanceTo(double latitude, double longitude) {
    return Geolocator.distanceBetween(
          _center.latitude,
          _center.longitude,
          latitude,
          longitude,
        ) /
        1000;
  }
}
