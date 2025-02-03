import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotifications {
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future init() async {
    var androidInitilization =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitilization = DarwinInitializationSettings();

    var initilizationSettings = InitializationSettings(
      android: androidInitilization,
      iOS: iosInitilization,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initilizationSettings,
      onDidReceiveNotificationResponse: (payload) {},
    );
  }

  static Future showNotification({
    required String title,
    required String body,
    required String payload,
  }) async {
    final String channelId = Random.secure().nextInt(100000).toString();
    AndroidNotificationChannel channel = AndroidNotificationChannel(
      channelId,
      "High Importance Notifications",
      importance: Importance.max,
    );

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      channel.id,
      channel.name,
      channelDescription: "Your Channel Description",
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker',
    );

    DarwinNotificationDetails iOSNotificationDetails =
        DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iOSNotificationDetails,
    );

    await _flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }
}
