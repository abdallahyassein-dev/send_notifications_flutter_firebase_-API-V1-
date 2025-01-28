import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;

Future<String> getAccessToken() async {
  final jsonString = await rootBundle.loadString(
    'JSON PATH',
  );

  final accountCredentials =
      auth.ServiceAccountCredentials.fromJson(jsonString);

  final scopes = ['https://www.googleapis.com/auth/firebase.messaging'];
  final client = await auth.clientViaServiceAccount(accountCredentials, scopes);

  return client.credentials.accessToken.data;
}

Future<void> sendNotification(String token, String title, String body) async {
  final String accessToken = await getAccessToken();
  final String fcmUrl =
      'https://fcm.googleapis.com/v1/projects/PROOJECT_ID/messages:send';

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
      },
    }),
  );

  if (response.statusCode == 200) {
    print('Notification sent successfully');
  } else {
    print('Failed to send notification: ${response.body}');
  }
}
