import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../core/supabase/supabase_client.dart';
import '../data/models/profile_model.dart';
import '../data/repositories/auth_repository.dart';

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
      firstName: params.firstName,
      lastName: params.lastName,
      phone: params.phone,
      gender: params.gender,
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
  final String firstName;
  final String lastName;
  final String? phone;
  final String? gender;
  SignUpParams({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    this.phone,
    this.gender,
  });
}
