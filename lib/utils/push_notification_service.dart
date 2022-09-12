import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<String> getUUId() async {
  var deviceInfo = DeviceInfoPlugin();
  if (Platform.isIOS) {
    var iosDeviceInfo = await deviceInfo.iosInfo;
    return iosDeviceInfo.identifierForVendor; // unique ID on iOS
  } else {
    var androidDeviceInfo = await deviceInfo.androidInfo;
    return androidDeviceInfo.androidId; // unique ID on Android
  }
}

class PushNotificationService {
  static PushNotificationService? _instance;

  PushNotificationService._();

  static PushNotificationService get shared =>
      _instance ??= PushNotificationService._();

  String? fcmToken;
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  setup() async {
    messaging.getToken().then((value) {
      fcmToken = value;
      debugPrint("FCMToken: $value");
      registerDevice();
    });
    await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    var initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = const IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    FirebaseMessaging.onMessage.listen(_firebaseOnMessageHandler);
  }

  Future<void> _firebaseOnMessageHandler(RemoteMessage message) async {
    showNotification(
        message.notification?.title ?? "", message.notification?.body ?? "");
    debugPrint("onMessage: $message");
  }

  registerDevice() async {
    // String uuid = await getUUId();
    // RegisterDeviceForm form =
    //     RegisterDeviceForm(fcmToken: fcmToken ?? "", uuid: uuid);
    // final _service = Injector().userService;
    // _service.registerDevice(form);
  }

  Future<void> showNotification(String title, String body) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        'Now KPI', 'Now KPI',
        importance: Importance.max,
        playSound: true,
        showProgress: true,
        priority: Priority.high);

    var iOSChannelSpecifics = const IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iOSChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, title, body, platformChannelSpecifics);
  }
}
