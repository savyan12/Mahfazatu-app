import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/supabase/supabase_client.dart';
import '../data/models/reward_model.dart';
import '../data/repositories/reward_repository.dart';

final rewardRepositoryProvider = Provider<RewardRepository>((ref) {
  return RewardRepository(SupabaseService.I);
});

final rewardsProvider = FutureProvider<List<RewardModel>>((ref) async {
  final repo = ref.watch(rewardRepositoryProvider);
  return repo.getRewards();
});
