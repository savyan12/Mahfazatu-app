import '../../core/supabase/supabase_client.dart';
import '../models/merchant_model.dart';
import '../models/branch_model.dart';

class MerchantRepository {
  final SupabaseService _supabase;

  MerchantRepository(this._supabase);

  Future<List<MerchantModel>> getMerchants({String? serviceType}) async {
    var query = _supabase.client
        .from('merchant')
        .select('*, profile!inner(name)');

    if (serviceType != null && serviceType.isNotEmpty) {
      query = query.eq('service_type', serviceType);
    }

    final data = await query.order('merchant_code');
    return data.map((json) => MerchantModel.fromJson(json)).toList();
  }

  Future<MerchantModel> getMerchant(int userId) async {
    final data = await _supabase.client
        .from('merchant')
        .select()
        .eq('user_id', userId)
        .single();
    return MerchantModel.fromJson(data);
  }

  Future<List<BranchModel>> getBranches(int merchantId) async {
    final data = await _supabase.client
        .from('branch')
        .select()
        .eq('merchant_id', merchantId)
        .eq('is_active', true);
    return data.map((json) => BranchModel.fromJson(json)).toList();
  }
}
