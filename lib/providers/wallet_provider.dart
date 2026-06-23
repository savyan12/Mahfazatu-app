import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/supabase/supabase_client.dart';
import '../data/models/card_model.dart';
import '../data/repositories/wallet_repository.dart';

final walletRepositoryProvider = Provider<WalletRepository>((ref) {
  return WalletRepository(SupabaseService.I);
});

final balanceProvider = FutureProvider.family<double, String>(
  (ref, userId) async {
    final repo = ref.watch(walletRepositoryProvider);
    return repo.getBalance(userId);
  },
);

final cardsProvider = FutureProvider.family<List<CardModel>, String>(
  (ref, userId) async {
    final repo = ref.watch(walletRepositoryProvider);
    return repo.getCards(userId);
  },
);
