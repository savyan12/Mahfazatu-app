import '../../core/supabase/supabase_client.dart';
import '../models/profile_model.dart';

class ProfileRepository {
  final SupabaseService _supabase;

  ProfileRepository(this._supabase);

  Future<ProfileModel> getProfile(String authUid) async {
    final data = await _supabase.client
        .from('profile')
        .select()
        .eq('auth_uid', authUid)
        .single();
    return ProfileModel.fromJson(data);
  }

  Future<ProfileModel> getProfileByUserId(int userId) async {
    final data = await _supabase.client
        .from('profile')
        .select()
        .eq('user_id', userId)
        .single();
    return ProfileModel.fromJson(data);
  }

  Future<ProfileModel> updateProfile({
    required int userId,
    String? name,
    String? phoneNumber,
  }) async {
    final updates = <String, dynamic>{};
    if (name != null) updates['name'] = name;
    if (phoneNumber != null) updates['phone_number'] = phoneNumber;

    final data = await _supabase.client
        .from('profile')
        .update(updates)
        .eq('user_id', userId)
        .select()
        .single();
    return ProfileModel.fromJson(data);
  }
}
