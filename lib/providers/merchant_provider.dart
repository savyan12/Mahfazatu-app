import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/supabase/supabase_client.dart';
import '../data/models/merchant_model.dart';
import '../data/repositories/merchant_repository.dart';

final merchantRepositoryProvider = Provider<MerchantRepository>((ref) {
  return MerchantRepository(SupabaseService.I);
});

final merchantsProvider =
    FutureProvider<List<MerchantModel>>((ref) async {
  final repo = ref.watch(merchantRepositoryProvider);
  return repo.getMerchants();
});

final merchantsByServiceProvider =
    FutureProvider.family<List<MerchantModel>, String>(
  (ref, serviceType) async {
    final repo = ref.watch(merchantRepositoryProvider);
    return repo.getMerchants(serviceType: serviceType);
  },
);
