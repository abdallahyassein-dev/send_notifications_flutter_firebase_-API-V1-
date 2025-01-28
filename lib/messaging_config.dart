import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class MessagingConfig {
  static initFirebaseMessaging() async {
    FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    // flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
    // AndroidFlutterLocalNotificationsPlugin>()!.requestNotificationsPermission();
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    AndroidNotificationChannel channel = const AndroidNotificationChannel(
        'high_importance_channel', 'Hight Importance Notifications',
        description: 'This channel is used for important notifications.',
        importance: Importance.max);

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );

    InitializationSettings initializationSettings =
        const InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS,
            macOS: null);

    flutterLocalNotificationsPlugin!.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (payload) {
        log("payload1: ${payload.toString()}");
        try {
          log("payload: ${payload.toString()}");
        } catch (e) {
          log("Exception: $e");
        }
        return;
      },
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      log('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      log('User granted provisional permission');
    } else {
      log('User declined or has not accepted permission');
    }
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      log("message recieved");
      try {
        RemoteNotification? notification = event.notification;
        AndroidNotification? android = event.notification?.android;
        log(notification!.body.toString());
        log(notification.title.toString());
        // var jsdata = json.decode(notification!.body!);
        var body = notification.body;
        flutterLocalNotificationsPlugin!.show(
            notification.hashCode,
            notification.title,
            body,
            NotificationDetails(
                iOS: const DarwinNotificationDetails(
                    presentAlert: true, presentBadge: true, presentSound: true),
                android: AndroidNotificationDetails(channel.id, channel.name,
                    channelDescription: channel.description,
                    icon: '@mipmap/ic_launcher')));
      } catch (err) {
        log(err.toString());
      }
      //   Fluttertoast.showToast(
      //     msg: event.notification!.title.toString() + "\n" + event.notification!.body.toString(),
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.CENTER,
      //     timeInSecForIosWeb: 1,
      //     backgroundColor: Colors.greenAccent,
      //     textColor: Colors.white,
      //     fontSize: 16.0
      // );
      //  log(event.notification!.body.toString());
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      log('Message clicked!');
    });
  }

  @pragma('vm:entry-point')
  static Future<void> messageHandler(RemoteMessage message) async {
    log('background message ${message.notification!.body}');
    //  Fluttertoast.showToast(
    //       msg:  message.notification!.title.toString() + "\n" + message.notification!.body.toString(),
    //       toastLength: Toast.LENGTH_SHORT,
    //       gravity: ToastGravity.CENTER,
    //       timeInSecForIosWeb: 1,
    //        backgroundColor: Colors.greenAccent,
    //       textColor: Colors.white,
    //       fontSize: 16.0
    //   );
  }
}
