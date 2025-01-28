import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:send_notification_example/firebase_options.dart';
import 'package:send_notification_example/messaging_config.dart';
import 'package:send_notification_example/send_notification_services.dart';

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
                sendNotification('FCM_TOKEN_YOU_WANT_TO_SEND_NOTIFICATIONS_TO',
                    'Hello Abdallah!', 'This is a new test notification.');
              },
              child: Text('Send Notification'),
            ),
          )
        ],
      ),
    );
  }
}
