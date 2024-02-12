import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterfirebasenotification/helper/notifications/flutter_local_notification_handler.dart';
import 'package:open_settings/open_settings.dart';

class FlutterFirebaseNotifications {
  final FirebaseMessaging firebaseMessagingInstance =
      FirebaseMessaging.instance;

  FlutterLocalNotificationHandler flutterLocalNotificationHandler =
      FlutterLocalNotificationHandler();

  /*------------------> Getting Notification Permission <----------------------*/
  Future<void> getNotificationPermission() async {
    final notificationPermission =
        await firebaseMessagingInstance.requestPermission(
      provisional: true,
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      sound: true,
    );

    if (notificationPermission.authorizationStatus ==
        AuthorizationStatus.authorized) {
      debugPrint('Granted');
    } else if (notificationPermission.authorizationStatus ==
        AuthorizationStatus.provisional) {
      debugPrint('Provisional');
    } else {
      OpenSettings.openNotificationAssistantSetting();
    }
  }

  Future<void> setInteractMessage({required BuildContext context}) async {
    await firebaseMessagingInstance.getInitialMessage().then((value) {
      if (value != null) {
        showNotification(context: context);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      showNotification(context: context);
    });
  }

  /*--------------------> Getting Device Token <---------------------*/
  Future<String> getDeviceToken() async {
    getRefreshToken();
    final apnsToken = await firebaseMessagingInstance.getToken();
    return apnsToken.toString();
  }

  /*---------------------> Token Refresh <-------------------------*/
  void getRefreshToken() {
    firebaseMessagingInstance.onTokenRefresh.listen((event) {});
  }

  /*---------------------> Notification Messages Show <----------------------*/
  void showNotification({required BuildContext context}) {
    FirebaseMessaging.onMessage.listen((event) {
      flutterLocalNotificationHandler.initNotifications(
          message: event, context: context);
    });
  }
}
