import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:send_notification_example/product_details_screen.dart';

Future<String> getAccessToken() async {
  final jsonString = await rootBundle.loadString(
    'assets/notifications_key/testsignin-1a319-f951911b6a71.json',
  );

  final accountCredentials =
      auth.ServiceAccountCredentials.fromJson(jsonString);

  final scopes = ['https://www.googleapis.com/auth/firebase.messaging'];
  final client = await auth.clientViaServiceAccount(accountCredentials, scopes);

  return client.credentials.accessToken.data;
}

Future<void> sendNotification(
    {required String token,
    required String title,
    required String body,
    required Map<String, String> data}) async {
  final String accessToken = await getAccessToken();
  final String fcmUrl =
      'https://fcm.googleapis.com/v1/projects/"PROJECT_ID"/messages:send';

  final response = await http.post(
    Uri.parse(fcmUrl),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    },
    body: jsonEncode(<String, dynamic>{
      'message': {
        'token': token,
        'notification': {
          'title': title,
          'body': body,
        },
        'data': data, // Add custom data here

        'android': {
          'notification': {
            "sound": "custom_sound",
            'click_action':
                'FLUTTER_NOTIFICATION_CLICK', // Required for tapping to trigger response
            'channel_id': 'high_importance_channel'
          },
        },
        'apns': {
          'payload': {
            'aps': {"sound": "custom_sound.caf", 'content-available': 1},
          },
        },
      },
    }),
  );

  if (response.statusCode == 200) {
    print('Notification sent successfully');
  } else {
    print('Failed to send notification: ${response.body}');
  }
}

void handleNotification(BuildContext context, Map<String, dynamic> data) {
  String route = data['route'];
  String id = data['id'];

  if (route == '/product_detials') {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ProductDetailsScreen(productId: id)),
    );
  }
}
