import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../core/supabase/supabase_client.dart';
import '../data/models/profile_model.dart';
import '../data/repositories/auth_repository.dart';
import 'profile_provider.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(SupabaseService.I);
});

final authStateProvider = StreamProvider<AuthState>((ref) {
  return SupabaseService.I.auth.onAuthStateChange;
});

final currentUserProvider = Provider<User?>((ref) {
  return SupabaseService.I.auth.currentUser;
});


final authLoadingProvider = StateProvider<bool>((ref) => false);

final currentUserIdProvider = FutureProvider<int>((ref) async {
  final user = ref.watch(currentUserProvider);
  if (user == null) throw Exception('Not authenticated');
  final repo = ref.watch(profileRepositoryProvider);
  final profile = await repo.getProfile(user.id);
  return profile.userId;
});

final signInProvider = FutureProvider.family<ProfileModel, SignInParams>(
  (ref, params) async {
    final repo = ref.watch(authRepositoryProvider);
    return repo.signIn(email: params.email, password: params.password);
  },
);

final signUpProvider = FutureProvider.family<ProfileModel, SignUpParams>(
  (ref, params) async {
    final repo = ref.watch(authRepositoryProvider);
    return repo.signUp(
      email: params.email,
      password: params.password,
      fullName: params.fullName,
      phoneNumber: params.phoneNumber,
      userType: params.userType,
    );
  },
);

class SignInParams {
  final String email;
  final String password;
  SignInParams({required this.email, required this.password});
}

class SignUpParams {
  final String email;
  final String password;
  final String fullName;
  final String? phoneNumber;
  final String userType;
  SignUpParams({
    required this.email,
    required this.password,
    required this.fullName,
    this.phoneNumber,
    this.userType = 'customer',
  });
}
