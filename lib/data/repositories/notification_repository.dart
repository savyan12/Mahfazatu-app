import '../../core/supabase/supabase_client.dart';
import '../models/notification_model.dart';

class NotificationRepository {
  final SupabaseService _supabase;

  NotificationRepository(this._supabase);

  Future<List<NotificationModel>> getNotifications(int userId) async {
    final data = await _supabase.client
        .from('notification')
        .select()
        .eq('user_id', userId)
        .order('sent_at', ascending: false);
    return data.map((json) => NotificationModel.fromJson(json)).toList();
  }

  Future<int> getUnreadCount(int userId) async {
    final data = await _supabase.client
        .from('notification')
        .select('notification_id')
        .eq('user_id', userId)
        .eq('is_read', false);
    return data.length;
  }

  Future<void> markAsRead(int notificationId) async {
    await _supabase.client
        .from('notification')
        .update({'is_read': true})
        .eq('notification_id', notificationId);
  }

  Future<void> markAllAsRead(int userId) async {
    await _supabase.client
        .from('notification')
        .update({'is_read': true})
        .eq('user_id', userId)
        .eq('is_read', false);
  }
}
