import '../../core/supabase/supabase_client.dart';
import '../models/profile_model.dart';

class ProfileRepository {
  final SupabaseService _supabase;

  ProfileRepository(this._supabase);

  Future<ProfileModel> getProfile(String userId) async {
    final data = await _supabase.client
        .from('profiles')
        .select()
        .eq('id', userId)
        .single();
    return ProfileModel.fromJson(data);
  }

  Future<ProfileModel> updateProfile({
    required String userId,
    String? firstName,
    String? lastName,
    String? phone,
    String? gender,
    String? avatarUrl,
  }) async {
    final updates = <String, dynamic>{
      'updated_at': DateTime.now().toIso8601String(),
    };
    if (firstName != null) updates['first_name'] = firstName;
    if (lastName != null) updates['last_name'] = lastName;
    if (phone != null) updates['phone'] = phone;
    if (gender != null) updates['gender'] = gender;
    if (avatarUrl != null) updates['avatar_url'] = avatarUrl;

    final data = await _supabase.client
        .from('profiles')
        .update(updates)
        .eq('id', userId)
        .select()
        .single();
    return ProfileModel.fromJson(data);
  }
}
