import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/supabase/supabase_client.dart';
import '../data/models/offer_model.dart';
import '../data/repositories/reward_repository.dart';

final rewardRepositoryProvider = Provider<RewardRepository>((ref) {
  return RewardRepository(SupabaseService.I);
});

final offersProvider = FutureProvider<List<OfferModel>>((ref) async {
  final repo = ref.watch(rewardRepositoryProvider);
  return repo.getOffers();
});
