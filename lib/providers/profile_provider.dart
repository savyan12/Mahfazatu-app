import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/supabase/supabase_client.dart';
import '../data/models/profile_model.dart';
import '../data/repositories/profile_repository.dart';

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepository(SupabaseService.I);
});

final profileProvider =
    FutureProvider.family<ProfileModel, String>((ref, userId) async {
  final repo = ref.watch(profileRepositoryProvider);
  return repo.getProfile(userId);
});
