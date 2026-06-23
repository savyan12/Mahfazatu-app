class NotificationModel {
  final int notificationId;
  final int userId;
  final String message;
  final String notifType;
  final bool isRead;
  final DateTime sentAt;

  NotificationModel({
    required this.notificationId,
    required this.userId,
    required this.message,
    this.notifType = 'general',
    this.isRead = false,
    required this.sentAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        notificationId: json['notification_id'] as int,
        userId: json['user_id'] as int,
        message: json['message'] as String,
        notifType: (json['notif_type'] as String?) ?? 'general',
        isRead: (json['is_read'] as bool?) ?? false,
        sentAt: DateTime.parse(json['sent_at'] as String),
      );

  Map<String, dynamic> toJson() => {
    'notification_id': notificationId,
    'user_id': userId,
    'message': message,
    'notif_type': notifType,
    'is_read': isRead,
    'sent_at': sentAt.toIso8601String(),
  };

  NotificationModel copyWith({bool? isRead}) => NotificationModel(
    notificationId: notificationId,
    userId: userId,
    message: message,
    notifType: notifType,
    isRead: isRead ?? this.isRead,
    sentAt: sentAt,
  );
}
