// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBvo6bvNfTRLLoSs7zY1eDllnbljqckAtM',
    appId: '1:937281614957:android:cac70d71e9cc7721e0bb64',
    messagingSenderId: '937281614957',
    projectId: 'testsignin-1a319',
    storageBucket: 'testsignin-1a319.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB0guqdNoI7VSUnq5M8rRq0dVO_UgFj4t4',
    appId: '1:937281614957:ios:84fa9434eb936d2de0bb64',
    messagingSenderId: '937281614957',
    projectId: 'testsignin-1a319',
    storageBucket: 'testsignin-1a319.firebasestorage.app',
    androidClientId: '937281614957-54schs4c37t15f3b652npag34s8va2j3.apps.googleusercontent.com',
    iosClientId: '937281614957-9h6tmri39ltif6uoa3ul27bf3dd8j6cp.apps.googleusercontent.com',
    iosBundleId: 'com.example.sendNotificationExample',
  );
}
