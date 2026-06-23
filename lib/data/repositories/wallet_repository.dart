import '../../core/supabase/supabase_client.dart';
import '../models/wallet_model.dart';

class WalletRepository {
  final SupabaseService _supabase;

  WalletRepository(this._supabase);

  Future<WalletModel> getWallet(int userId) async {
    final data = await _supabase.client
        .from('wallet')
        .select()
        .eq('user_id', userId)
        .single();
    return WalletModel.fromJson(data);
  }

  Future<double> getBalance(int userId) async {
    final data = await _supabase.client
        .from('wallet')
        .select('balance')
        .eq('user_id', userId)
        .single();
    return (data['balance'] as num).toDouble();
  }

  Future<int> getPoints(int userId) async {
    final data = await _supabase.client
        .from('wallet')
        .select('points')
        .eq('user_id', userId)
        .single();
    return (data['points'] as int);
  }
}
