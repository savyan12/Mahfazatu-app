import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/supabase/supabase_client.dart';
import '../data/models/notification_model.dart';
import '../data/repositories/notification_repository.dart';

final notificationRepositoryProvider = Provider<NotificationRepository>((ref) {
  return NotificationRepository(SupabaseService.I);
});

final notificationsProvider =
    FutureProvider.family<List<NotificationModel>, int>(
  (ref, userId) async {
    final repo = ref.watch(notificationRepositoryProvider);
    return repo.getNotifications(userId);
  },
);

final unreadCountProvider = FutureProvider.family<int, int>(
  (ref, userId) async {
    final repo = ref.watch(notificationRepositoryProvider);
    return repo.getUnreadCount(userId);
  },
);
