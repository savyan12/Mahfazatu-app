import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../../core/theme/app_colors.dart';

class MarketplacePageView extends StatefulWidget {
  const MarketplacePageView({super.key});

  static const routeName = '/marketplace';

  @override
  State<MarketplacePageView> createState() => _MarketplacePageViewState();
}

class _MarketplacePageViewState extends State<MarketplacePageView> {
  static const LatLng _tripoliFallback = LatLng(32.8872, 13.1913);
  LatLng _center = _tripoliFallback;
  bool _loadingLocation = true;
  String _locationLabel = 'ليبيا - طرابلس';
  String _locationStatus = 'جارٍ تحديد الموقع الحالي...';

  @override
  void initState() {
    super.initState();
    _loadCurrentLocation();
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
        desiredAccuracy: LocationAccuracy.high,
      );

      if (!mounted) return;
      setState(() {
        _center = LatLng(position.latitude, position.longitude);
        _loadingLocation = false;
        _locationLabel = 'الموقع الحالي';
        _locationStatus = 'تم تحديد موقعك الحالي على الخريطة.';
      });
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
                    options: const MapOptions(
                      initialCenter: LatLng(32.8872, 13.1913),
                      initialZoom: 13.2,
                      interactionOptions: InteractionOptions(
                        flags: InteractiveFlag.none,
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
                                ? const _MapPin(
                                    icon: Icons.location_searching_rounded,
                                    accent: AppColors.sky,
                                  )
                                : const _MapPin(
                                    icon: Icons.my_location_rounded,
                                    accent: AppColors.sky,
                                  ),
                          ),
                          Marker(
                            point: LatLng(
                              _center.latitude + 0.004,
                              _center.longitude - 0.006,
                            ),
                            width: 40,
                            height: 40,
                            child: _MapPin(
                              icon: Icons.shopping_bag_outlined,
                              accent: AppColors.mint,
                            ),
                          ),
                          Marker(
                            point: LatLng(
                              _center.latitude - 0.004,
                              _center.longitude + 0.006,
                            ),
                            width: 40,
                            height: 40,
                            child: _MapPin(
                              icon: Icons.local_cafe_outlined,
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
                children: const [
                  Expanded(
                    child: _CategoryTile(
                      label: 'الكل',
                      icon: Icons.grid_view_rounded,
                      active: true,
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: _CategoryTile(
                      label: 'تسوق',
                      icon: Icons.shopping_bag_outlined,
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: _CategoryTile(
                      label: 'مطاعم',
                      icon: Icons.restaurant_outlined,
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: _CategoryTile(
                      label: 'خدمات',
                      icon: Icons.work_outline_rounded,
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
              _StoreCard(
                name: 'مقهى رواء',
                category: 'مقاهي',
                rating: '4.8',
                distance:
                    '${_distanceTo(_center.latitude + 0.001, _center.longitude + 0.001).toStringAsFixed(1)} كم',
                icon: Icons.local_cafe,
                accent: AppColors.card,
              ),
              const SizedBox(height: 10),
              _StoreCard(
                name: 'سوبر ماركت المدينة',
                category: 'تسوق',
                rating: '4.6',
                distance:
                    '${_distanceTo(_center.latitude + 0.003, _center.longitude - 0.002).toStringAsFixed(1)} كم',
                icon: Icons.shopping_cart,
                accent: AppColors.teal,
              ),
              const SizedBox(height: 10),
              _StoreCard(
                name: 'مطعم بيت الشاورما',
                category: 'مطاعم',
                rating: '4.5',
                distance:
                    '${_distanceTo(_center.latitude - 0.004, _center.longitude + 0.004).toStringAsFixed(1)} كم',
                icon: Icons.restaurant,
                accent: AppColors.danger,
              ),
              const SizedBox(height: 10),
              _StoreCard(
                name: 'عيادة النهدي',
                category: 'خدمات',
                rating: '4.7',
                distance:
                    '${_distanceTo(_center.latitude - 0.006, _center.longitude - 0.003).toStringAsFixed(1)} كم',
                icon: Icons.favorite,
                accent: AppColors.sky,
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

class _MapPin extends StatelessWidget {
  const _MapPin({required this.icon, required this.accent});

  final IconData icon;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.94),
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Icon(icon, color: AppColors.backgroundBottom, size: 18),
    );
  }
}

class _CategoryTile extends StatelessWidget {
  const _CategoryTile({
    required this.label,
    required this.icon,
    this.active = false,
  });

  final String label;
  final IconData icon;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = active ? AppColors.mint : Colors.transparent;
    final foregroundColor = active ? AppColors.card : AppColors.mint;

    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.mint.withValues(alpha: 0.55)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: foregroundColor, size: 18),
          const SizedBox(height: 3),
          Text(
            label,
            style: TextStyle(
              color: foregroundColor,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _StoreCard extends StatelessWidget {
  const _StoreCard({
    required this.name,
    required this.category,
    required this.rating,
    required this.distance,
    required this.icon,
    required this.accent,
  });

  final String name;
  final String category;
  final String rating;
  final String distance;
  final IconData icon;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.card.withValues(alpha: 0.72),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Row(
        children: [
          Container(
            width: 62,
            height: 62,
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.22),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: accent, size: 30),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  name,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  category,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    color: AppColors.mutedText,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      rating,
                      style: const TextStyle(
                        color: AppColors.mint,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      distance,
                      style: const TextStyle(
                        color: AppColors.mutedText,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.chevron_left_rounded, color: Colors.white),
        ],
      ),
    );
  }
}
