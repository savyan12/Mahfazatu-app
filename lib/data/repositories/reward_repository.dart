import '../../core/supabase/supabase_client.dart';
import '../models/reward_model.dart';
import '../models/user_reward_model.dart';

class RewardRepository {
  final SupabaseService _supabase;

  RewardRepository(this._supabase);

  Future<List<RewardModel>> getRewards({int? merchantId}) async {
    var query = _supabase.client
        .from('reward')
        .select()
        .eq('is_active', true);

    if (merchantId != null) {
      query = query.eq('merchant_id', merchantId);
    }

    final data = await query.order('required_points');
    return data.map((json) => RewardModel.fromJson(json)).toList();
  }

  Future<void> redeemPoints({
    required int userId,
    required int rewardId,
  }) async {
    final reward = await _supabase.client
        .from('reward')
        .select('required_points')
        .eq('reward_id', rewardId)
        .single();

    await _supabase.client.from('user_reward').insert({
      'user_id': userId,
      'reward_id': rewardId,
      'points_spent': reward['required_points'],
    });
  }

  Future<List<UserRewardModel>> getRedemptions(int userId) async {
    final data = await _supabase.client
        .from('user_reward')
        .select()
        .eq('user_id', userId)
        .order('redeemed_at', ascending: false);
    return data.map((json) => UserRewardModel.fromJson(json)).toList();
  }
}
