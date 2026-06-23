import '../../core/supabase/supabase_client.dart';
import '../models/prepaid_card_model.dart';

class PrepaidCardRepository {
  final SupabaseService _supabase;

  PrepaidCardRepository(this._supabase);

  Future<PrepaidCardModel> getCard(String code) async {
    final data = await _supabase.client
        .from('prepaid_card')
        .select()
        .eq('code', code)
        .single();
    return PrepaidCardModel.fromJson(data);
  }

  Future<PrepaidCardModel> redeemCard({
    required String code,
    required int userId,
  }) async {
    final card = await getCard(code);
    if (!card.isValid) throw Exception('Card is already used or expired');

    final data = await _supabase.client
        .from('prepaid_card')
        .update({'is_used': true, 'used_by': userId, 'used_at': DateTime.now().toIso8601String()})
        .eq('code', code)
        .select()
        .single();

    final wallet = await _supabase.client
        .from('wallet')
        .select('wallet_id')
        .eq('user_id', userId)
        .single();

    await _supabase.client.from('transaction').insert({
      'sender_wallet_id': wallet['wallet_id'],
      'receiver_wallet_id': wallet['wallet_id'],
      'transaction_type': 'payment',
      'amount': card.amount,
      'payment_method': 'direct',
      'status': 'completed',
      'notes': 'Prepaid card top-up: ${card.code}',
    });

    return PrepaidCardModel.fromJson(data);
  }
}
