import 'package:flutter/material.dart';
import 'package:flutterfirebasenotification/helper/notifications/flutter_firebase_notifications.dart';
import 'package:flutterfirebasenotification/helper/notifications/flutter_local_notification_handler.dart';
import 'package:provider/provider.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  FlutterFirebaseNotifications firebaseNotifications =
      FlutterFirebaseNotifications();

  FlutterLocalNotificationHandler flutterLocalNotificationHandler =
      FlutterLocalNotificationHandler();

  void startupNotifications() async {
    await firebaseNotifications.getNotificationPermission();
    await firebaseNotifications.getDeviceToken().then((value) {
      firebaseNotifications.showNotification(context: context);
    });
  }

  @override
  void initState() {
    startupNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: GestureDetector(
          child: Container(
            alignment: Alignment.center,
            height: screenSize.height * .05,
            width: screenSize.width * .8,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              'Clickable Button',
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        ),
      ),
    );
  }
}
