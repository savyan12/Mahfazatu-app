import 'package:supabase_flutter/supabase_flutter.dart';
import '../../core/supabase/supabase_client.dart';
import '../models/profile_model.dart';

class AuthRepository {
  final SupabaseService _supabase;

  AuthRepository(this._supabase);

  SupabaseClient get _client => _supabase.client;

  User? get currentUser => _client.auth.currentUser;

  Stream<AuthState> get authStateChanges => _client.auth.onAuthStateChange;

  Future<ProfileModel> signUp({
    required String email,
    required String password,
    required String fullName,
    String? phoneNumber,
    String userType = 'customer',
  }) async {
    final response = await _client.auth.signUp(
      email: email,
      password: password,
      data: {
        'name': fullName,
        'phone_number': phoneNumber,
        'user_type': userType,
      },
    );
    final user = response.user;
    if (user == null) throw Exception('Sign up failed');

    final profile = await _client
        .from('profile')
        .select()
        .eq('auth_uid', user.id)
        .single();
    return ProfileModel.fromJson(profile);
  }

  Future<ProfileModel> signIn({
    required String email,
    required String password,
  }) async {
    final response = await _client.auth.signInWithPassword(
      email: email,
      password: password,
    );
    final user = response.user;
    if (user == null) throw Exception('Invalid credentials');

    final profile = await _client
        .from('profile')
        .select()
        .eq('auth_uid', user.id)
        .single();
    return ProfileModel.fromJson(profile);
  }

  Future<void> signOut() async {
    await _client.auth.signOut();
  }
}
