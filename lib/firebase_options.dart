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
      return web;
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCXYxja9SNP7rq3sBIDAdL7A8TYUAJktYI',
    appId: '1:13529521712:web:90a0909670a593edfbd7f5',
    messagingSenderId: '13529521712',
    projectId: 'cpdoffice-29108',
    authDomain: 'cpdoffice-29108.firebaseapp.com',
    databaseURL: 'https://cpdoffice-29108-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'cpdoffice-29108.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD93X_K3cqoJbWUeRM5eo2xs23kvgBOCQI',
    appId: '1:13529521712:android:12e453f920ee560dfbd7f5',
    messagingSenderId: '13529521712',
    projectId: 'cpdoffice-29108',
    databaseURL: 'https://cpdoffice-29108-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'cpdoffice-29108.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBdYltAhVEA6IymjCUKl1pqkjz7Tfwvvq8',
    appId: '1:13529521712:ios:197e3ae444f276ecfbd7f5',
    messagingSenderId: '13529521712',
    projectId: 'cpdoffice-29108',
    databaseURL: 'https://cpdoffice-29108-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'cpdoffice-29108.appspot.com',
    iosClientId: '13529521712-8c11k7382kvl1t97aegrvfdh8lenvppu.apps.googleusercontent.com',
    iosBundleId: 'com.example.lgu',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBdYltAhVEA6IymjCUKl1pqkjz7Tfwvvq8',
    appId: '1:13529521712:ios:197e3ae444f276ecfbd7f5',
    messagingSenderId: '13529521712',
    projectId: 'cpdoffice-29108',
    databaseURL: 'https://cpdoffice-29108-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'cpdoffice-29108.appspot.com',
    iosClientId: '13529521712-8c11k7382kvl1t97aegrvfdh8lenvppu.apps.googleusercontent.com',
    iosBundleId: 'com.example.lgu',
  );
}