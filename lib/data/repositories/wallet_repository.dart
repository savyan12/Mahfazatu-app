import '../../core/supabase/supabase_client.dart';
import '../models/card_model.dart';

class WalletRepository {
  final SupabaseService _supabase;

  WalletRepository(this._supabase);

  Future<double> getBalance(String userId) async {
    final data = await _supabase.client
        .from('profiles')
        .select('balance')
        .eq('id', userId)
        .single();
    return (data['balance'] as num).toDouble();
  }

  Future<List<CardModel>> getCards(String userId) async {
    final data = await _supabase.client
        .from('cards')
        .select()
        .eq('user_id', userId)
        .order('created_at', ascending: false);
    return data.map((json) => CardModel.fromJson(json)).toList();
  }

  Future<CardModel> addCard(CardModel card) async {
    final data = await _supabase.client
        .from('cards')
        .insert(card.toJson())
        .select()
        .single();
    return CardModel.fromJson(data);
  }

  Future<void> deleteCard(String cardId) async {
    await _supabase.client.from('cards').delete().eq('id', cardId);
  }

  Future<double> redeemPrepaidCard({
    required String userId,
    required String code,
  }) async {
    final result = await _supabase.client.rpc(
      'redeem_prepaid_card',
      params: {'p_code': code, 'p_user_id': userId},
    );
    return (result as num).toDouble();
  }
}
