import '../../core/supabase/supabase_client.dart';
import '../models/transaction_model.dart';

class TransactionRepository {
  final SupabaseService _supabase;

  TransactionRepository(this._supabase);

  Future<List<TransactionModel>> getTransactions(String userId,
      {TransactionType? type, int limit = 50}) async {
    var query = _supabase.client
        .from('transactions')
        .select()
        .eq('user_id', userId);

    if (type != null) {
      query = query.eq('type', type.name);
    }

    final data = await query
        .order('created_at', ascending: false)
        .limit(limit);
    return data.map((json) => TransactionModel.fromJson(json)).toList();
  }

  Future<TransactionModel> createTransaction(
      TransactionModel transaction) async {
    final data = await _supabase.client
        .from('transactions')
        .insert(transaction.toJson())
        .select()
        .single();
    return TransactionModel.fromJson(data);
  }
}
