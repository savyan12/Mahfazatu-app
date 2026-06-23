import '../../core/supabase/supabase_client.dart';
import '../models/transaction_model.dart';

class TransactionRepository {
  final SupabaseService _supabase;

  TransactionRepository(this._supabase);

  Future<List<TransactionModel>> getTransactions(int userId,
      {TransactionType? type, int limit = 50}) async {
    final userWallets = await _supabase.client
        .from('wallet')
        .select('wallet_id')
        .eq('user_id', userId);

    if (userWallets.isEmpty) return [];

    final walletIds = userWallets.map((w) => w['wallet_id'] as int).toList();

    var query = _supabase.client
        .from('transaction')
        .select()
        .or(
            'sender_wallet_id.in.(${walletIds.join(',')}),receiver_wallet_id.in.(${walletIds.join(',')})');

    if (type != null) {
      query = query.eq('transaction_type', type.name);
    }

    final data = await query
        .order('transaction_date', ascending: false)
        .limit(limit);

    return data.map((json) => TransactionModel.fromJson(json)).toList();
  }

  Future<TransactionModel> createTransaction(
      TransactionModel transaction) async {
    final data = await _supabase.client
        .from('transaction')
        .insert(transaction.toJson())
        .select()
        .single();
    return TransactionModel.fromJson(data);
  }
}
