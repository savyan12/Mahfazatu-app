import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/supabase/supabase_client.dart';
import '../data/models/transaction_model.dart';
import '../data/repositories/transaction_repository.dart';

final transactionRepositoryProvider = Provider<TransactionRepository>((ref) {
  return TransactionRepository(SupabaseService.I);
});

final transactionsProvider =
    FutureProvider.family<List<TransactionModel>, int>(
  (ref, userId) async {
    final repo = ref.watch(transactionRepositoryProvider);
    return repo.getTransactions(userId);
  },
);
