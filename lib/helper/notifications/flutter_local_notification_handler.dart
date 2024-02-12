import 'dart:math';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutterfirebasenotification/core/views/message_screen.dart';

class FlutterLocalNotificationHandler {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  NotificationDetails notificationDetails = const NotificationDetails();

  /*----------------> Android Initialization Settings <---------------------*/
  void initNotifications(
      {required RemoteMessage message, required BuildContext context}) async {
    setNotification();
    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings();

    const initializationSettings =
        InitializationSettings(android: androidSettings, iOS: iosSettings);
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (payload) {
        if (message.data.isEmpty) {
          showNotification(message: message);
        } else {
          if (message.data['type'] != 'msg') {
            showNotification(message: message);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const MessageScreenView()));
          }
        }
      },
    );
  }

  /*---------------> Set Notification Details <-------------------*/
  void setNotification() {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
      Random.secure().nextInt(10000).toString(),
      "High Importance Notifications",
      importance: Importance.max,
    );

    AndroidNotificationDetails details = AndroidNotificationDetails(
      channel.id,
      channel.name,
      channelDescription: "Notification Channel Description",
      importance: Importance.high,
      priority: Priority.high,
      ticker: "ticker",
    );

    DarwinNotificationDetails iosDetails = const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentBanner: true,
      presentSound: true,
    );

    notificationDetails =
        NotificationDetails(android: details, iOS: iosDetails);
  }

  /*----------------> Show Flutter Notifications <-----------------*/
  void showNotification({required RemoteMessage message}) {
    Future.delayed(Duration.zero, () {
      flutterLocalNotificationsPlugin.show(
        0,
        message.notification!.title.toString(),
        message.notification!.body.toString(),
        notificationDetails,
      );
    });
  }
}
