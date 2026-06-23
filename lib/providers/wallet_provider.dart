import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/supabase/supabase_client.dart';
import '../data/models/wallet_model.dart';
import '../data/repositories/wallet_repository.dart';

final walletRepositoryProvider = Provider<WalletRepository>((ref) {
  return WalletRepository(SupabaseService.I);
});

final walletProvider = FutureProvider.family<WalletModel, int>(
  (ref, userId) async {
    final repo = ref.watch(walletRepositoryProvider);
    return repo.getWallet(userId);
  },
);

final balanceProvider = FutureProvider.family<double, int>(
  (ref, userId) async {
    final repo = ref.watch(walletRepositoryProvider);
    return repo.getBalance(userId);
  },
);

final pointsProvider = FutureProvider.family<int, int>(
  (ref, userId) async {
    final repo = ref.watch(walletRepositoryProvider);
    return repo.getPoints(userId);
  },
);
