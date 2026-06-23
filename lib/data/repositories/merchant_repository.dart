import '../../core/supabase/supabase_client.dart';
import '../models/merchant_model.dart';

class MerchantRepository {
  final SupabaseService _supabase;

  MerchantRepository(this._supabase);

  Future<List<MerchantModel>> getMerchants({String? category}) async {
    var query = _supabase.client
        .from('merchants')
        .select()
        .eq('is_active', true);

    if (category != null && category.isNotEmpty) {
      query = query.eq('category', category);
    }

    final data = await query.order('name');
    return data.map((json) => MerchantModel.fromJson(json)).toList();
  }

  Future<MerchantModel> getMerchant(String id) async {
    final data = await _supabase.client
        .from('merchants')
        .select()
        .eq('id', id)
        .single();
    return MerchantModel.fromJson(data);
  }
}
