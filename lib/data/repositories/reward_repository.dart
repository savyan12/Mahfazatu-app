import '../../core/supabase/supabase_client.dart';
import '../models/offer_model.dart';

class RewardRepository {
  final SupabaseService _supabase;

  RewardRepository(this._supabase);

  Future<List<OfferModel>> getOffers({String? merchantId}) async {
    var query = _supabase.client
        .from('offers')
        .select()
        .eq('is_active', true);

    if (merchantId != null && merchantId.isNotEmpty) {
      query = query.eq('merchant_id', merchantId);
    }

    final data = await query.order('points_required');
    return data.map((json) => OfferModel.fromJson(json)).toList();
  }

  Future<void> redeemPoints({
    required String userId,
    required String offerId,
  }) async {
    await _supabase.client.rpc(
      'redeem_points',
      params: {'p_user_id': userId, 'p_offer_id': offerId},
    );
  }

  Future<List<Map<String, dynamic>>> getRedemptions(String userId) async {
    final data = await _supabase.client
        .from('reward_redemptions')
        .select('*, offers(*)')
        .eq('user_id', userId)
        .order('created_at', ascending: false);
    return data;
  }
}
