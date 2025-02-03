import 'dart:io';
import 'dart:math';

import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:news_app/features/notification/notification_screen.dart';

class FirebaseNotifications {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void requestNotificationPermission() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      provisional: true,
      carPlay: true,
      criticalAlert: true,
      sound: true,
      badge: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      if (kDebugMode) {
        print("user granted permission");
      }
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      if (kDebugMode) {
        print("user granted provisional permission");
      }
    } else {
      AppSettings.openAppSettings();
      if (kDebugMode) {
        print("user denied permission");
      }
    }
  }

  Future<void> setupInteractMessage(BuildContext context) async {
    //when app is terminated
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      if (context.mounted) {
        handleMessage(context, initialMessage);
      }
    }

    //when app is in background
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      if (context.mounted) {
        handleMessage(context, message);
      }
    });
  }

  void handleMessage(BuildContext context, RemoteMessage message) {
    if (message.data["type"] == "msg") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NotificationScreen(message: message),
        ),
      );
    }
  }

  void initLocalNotification(
      BuildContext context, RemoteMessage message) async {
    var androidInitilization =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitilization = DarwinInitializationSettings();

    var initilizationSettings = InitializationSettings(
      android: androidInitilization,
      iOS: iosInitilization,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initilizationSettings,
      onDidReceiveNotificationResponse: (payload) =>
          handleMessage(context, message),
    );
  }

  void firebaseInit(BuildContext context) {
    FirebaseMessaging.onMessage.listen((message) {
      if (kDebugMode) {
        print(message.notification!.title);
        print(message.notification!.body);
        print(message.data["type"]);
        print(message.data["id"]);
      }
      if (Platform.isAndroid) {
        if (context.mounted) {
          initLocalNotification(context, message);
        }
        showNotification(message);
      } else {
        showNotification(message);
      }
    });
  }

  Future<void> showNotification(RemoteMessage message) async {
    if (message.notification?.title != null &&
        message.notification?.body != null) {
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

      int notificationId = Random().nextInt(100000);
      Future.delayed(Duration.zero, () {
        _flutterLocalNotificationsPlugin.show(
          notificationId,
          message.notification!.title,
          message.notification!.body,
          notificationDetails,
        );
      });
    } else {
      if (kDebugMode) {
        print("Notification data is null");
      }
    }
  }

  Future<String> getDeviceToken() async {
    String? token = await _firebaseMessaging.getToken();
    return token!;
  }

  void isTokenRefresh() {
    _firebaseMessaging.onTokenRefresh.listen((event) {
      event.toString();
      if (kDebugMode) {
        print("Refresh");
      }
    });
  }
}
