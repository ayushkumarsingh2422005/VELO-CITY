import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  NotificationService() {
    initialize();
  }

  Future<void> initialize() async {
    const initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    // For iOS settings, you can uncomment and configure if needed.
    // final initializationSettingsIOS = IOSInitializationSettings();

    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      // iOS: initializationSettingsIOS, // Uncomment if supporting iOS
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  Future<void> showNotification(String title, String body) async {
    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your_channel_id', // Provide a unique channel ID
      'your_channel_name',
      channelDescription: 'your_channel_description',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: true, // Display timestamp on notifications
    );

    const platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      // iOS: iOSPlatformChannelSpecifics, // If supporting iOS, define iOS details here
    );

    await _flutterLocalNotificationsPlugin.show(
      0, // Notification ID, can be incremented for multiple notifications
      title,
      body,
      platformChannelSpecifics,
      payload: 'notification_payload', // Optional payload
    );
  }
}
