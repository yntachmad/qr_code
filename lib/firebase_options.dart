// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        return macos;
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
    apiKey: 'AIzaSyC79NeOAmdZ7eXXVit9Rnh1uaLhxjfccsI',
    appId: '1:810998767759:android:eadbff7351d37d653110fa',
    messagingSenderId: '810998767759',
    projectId: 'qrcode-19cd6',
    storageBucket: 'qrcode-19cd6.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBkzTm7eEefyWFQTMlW2wHeQkZRCmdTHVs',
    appId: '1:810998767759:ios:b6518fb907cebdbf3110fa',
    messagingSenderId: '810998767759',
    projectId: 'qrcode-19cd6',
    storageBucket: 'qrcode-19cd6.appspot.com',
    iosBundleId: 'com.example.qrCode',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBkzTm7eEefyWFQTMlW2wHeQkZRCmdTHVs',
    appId: '1:810998767759:ios:c0c0b5f2cbd3a2893110fa',
    messagingSenderId: '810998767759',
    projectId: 'qrcode-19cd6',
    storageBucket: 'qrcode-19cd6.appspot.com',
    iosBundleId: 'com.example.qrCode.RunnerTests',
  );
}
