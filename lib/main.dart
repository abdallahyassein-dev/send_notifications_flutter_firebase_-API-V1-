import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:send_notification_example/firebase_options.dart';
import 'package:send_notification_example/messaging_config.dart';
import 'package:send_notification_example/send_notification_services.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  MessagingConfig.initFirebaseMessaging();
  FirebaseMessaging.onBackgroundMessage(MessagingConfig.messageHandler);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'FCM Example',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseMessaging.instance.getToken().then((value) => print(value));
    return Scaffold(
      appBar: AppBar(
        title: Text('FCM Example'),
      ),
      body: Column(
        children: [
          Center(
            child: Text('Push Notifications with FCM'),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                sendNotification(
                    token:
                        'erB0mqcqQL6yNu1M2z8Rp9:APA91bHSRDgnn1XaW3wc6K1HIwu_hsG9J1D-x90vNMgtFHe6wBb8RqQjAZZoRDlgzqYmrfBOI_LChOZDZM1_Jwl2bggYJVGmWKCAwLmyEomjZR6wchDzva0',
                    title: 'Hello Abdallah!',
                    body: 'This is a new test notification.',
                    data: {
                      "route": "/product_detials",
                      "id": "120",
                    });
              },
              child: Text('Send Notification'),
            ),
          )
        ],
      ),
    );
  }
}
