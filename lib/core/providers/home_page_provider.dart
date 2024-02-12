import 'package:flutter/foundation.dart';
import 'package:flutterfirebasenotification/helper/notifications/flutter_firebase_notifications.dart';

class HomePageProvider extends ChangeNotifier {
  FlutterFirebaseNotifications firebaseNotifications =
      FlutterFirebaseNotifications();
  String _deviceToken = '';

  String get deviceToken => _deviceToken;

  void getDeviceToken() async {
    _deviceToken = await firebaseNotifications.getDeviceToken();
    debugPrint(_deviceToken);
    notifyListeners();
  }
}
