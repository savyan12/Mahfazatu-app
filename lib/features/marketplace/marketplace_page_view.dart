import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../../core/theme/app_colors.dart';
import '../../data/merchant.dart';
import '../notifications/notifications_page_view.dart';
import 'marketplace_widgets.dart';

class MarketplacePageView extends StatefulWidget {
  const MarketplacePageView({super.key});

  static const routeName = '/marketplace';

  @override
  State<MarketplacePageView> createState() => _MarketplacePageViewState();
}

class _MarketplacePageViewState extends State<MarketplacePageView> {
  static const LatLng _tripoliFallback = LatLng(32.8872, 13.1913);
  late final MapController _mapController;
  final _searchController = TextEditingController();
  LatLng _center = _tripoliFallback;
  bool _loadingLocation = true;
  bool _loadingMerchants = true;
  String _locationLabel = 'ليبيا - طرابلس';
  String _locationStatus = 'جارٍ تحديد الموقع الحالي...';
  String _searchQuery = '';
  String? _selectedCategory;
  List<Merchant> _merchants = [];

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _loadMerchants();
    _loadCurrentLocation();
  }

  @override
  void dispose() {
    _mapController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadMerchants() async {
    try {
      final jsonString = await rootBundle.loadString('assets/data/merchants.json');
      final List<dynamic> decoded = jsonDecode(jsonString) as List<dynamic>;
      if (!mounted) return;
      setState(() {
        _merchants = decoded
            .map((e) => Merchant.fromJson(e as Map<String, dynamic>))
            .toList();
        _loadingMerchants = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() => _loadingMerchants = false);
    }
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

  List<Merchant> get _filteredMerchants {
    var result = _merchants;
    if (_selectedCategory != null) {
      result = result.where((m) => m.category == _selectedCategory).toList();
    }
    if (_searchQuery.isNotEmpty) {
      result = result
          .where((m) => m.name.contains(_searchQuery))
          .toList();
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
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
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        NotificationsPageView.routeName,
                      );
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.card.withValues(alpha: 0.95),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.mint.withValues(alpha: 0.25),
                        ),
                      ),
                      child: const Icon(
                        Icons.notifications_none_rounded,
                        color: AppColors.mint,
                        size: 22,
                      ),
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
                  border: Border.all(
                    color: AppColors.mint.withValues(alpha: 0.15),
                  ),
                ),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextField(
                    controller: _searchController,
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'ابحث عن متجر أو خدمة',
                      hintStyle: TextStyle(
                        color: AppColors.mutedText.withValues(alpha: 0.7),
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                      prefixIcon: const Icon(
                        Icons.search_rounded,
                        color: AppColors.mint,
                        size: 22,
                      ),
                      suffixIcon: _searchQuery.isNotEmpty
                          ? GestureDetector(
                              onTap: () {
                                _searchController.clear();
                                setState(() => _searchQuery = '');
                              },
                              child: const Icon(
                                Icons.close_rounded,
                                color: AppColors.mutedText,
                                size: 20,
                              ),
                            )
                          : null,
                    ),
                    onChanged: (value) {
                      setState(() => _searchQuery = value.trim());
                    },
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Container(
                height: 210,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: AppColors.mint.withValues(alpha: 0.2),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.mint.withValues(alpha: 0.08),
                      blurRadius: 18,
                      spreadRadius: 0,
                    ),
                  ],
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
                                    accent: AppColors.mint,
                                  )
                                : const MerchantMapPin(
                                    icon: Icons.my_location_rounded,
                                    accent: AppColors.mint,
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
                      active: _selectedCategory == 'تسوق',
                      onTap: () =>
                          setState(() => _selectedCategory = 'تسوق'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: MarketplaceCategoryTile(
                      label: 'مطاعم',
                      icon: Icons.restaurant_outlined,
                      active: _selectedCategory == 'مطاعم',
                      onTap: () =>
                          setState(() => _selectedCategory = 'مطاعم'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: MarketplaceCategoryTile(
                      label: 'خدمات',
                      icon: Icons.work_outline_rounded,
                      active: _selectedCategory == 'خدمات',
                      onTap: () =>
                          setState(() => _selectedCategory = 'خدمات'),
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
              _buildMerchantList(_filteredMerchants),
              const SizedBox(height: 14),
              Container(
                height: 44,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.mint.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: AppColors.mint.withValues(alpha: 0.3),
                  ),
                ),
                child: const Text(
                  'عرض المزيد من المتاجر',
                  style: TextStyle(
                    color: AppColors.mint,
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

  Widget _buildMerchantList(List<Merchant> merchants) {
    if (_loadingMerchants) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: CircularProgressIndicator(color: AppColors.mint),
        ),
      );
    }

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
            category: m.category,
            distance:
                '${_distanceTo(m.latitude, m.longitude).toStringAsFixed(1)} كم',
            icon: m.icon,
            accent: AppColors.mint,
          ),
        );
      }).toList(),
    );
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
