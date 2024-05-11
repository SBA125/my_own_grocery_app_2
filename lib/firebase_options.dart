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
        return windows;
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
    apiKey: 'AIzaSyDBr8KAJwYppg7yzQQckXDiIQr0y4lc3B4',
    appId: '1:521102319461:web:b53cc8e80be5e2df5e4b8c',
    messagingSenderId: '521102319461',
    projectId: 'groceryproject-49143',
    authDomain: 'groceryproject-49143.firebaseapp.com',
    storageBucket: 'groceryproject-49143.appspot.com',
    measurementId: 'G-92470YNM23',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB4AG2bp6O6glLsynUx_s0T-7GxfkwrIwk',
    appId: '1:521102319461:android:f6b1b7eda3d5fdca5e4b8c',
    messagingSenderId: '521102319461',
    projectId: 'groceryproject-49143',
    storageBucket: 'groceryproject-49143.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBZRb_tiTcdWO9cDmasbPBYwjexe46-zKU',
    appId: '1:521102319461:ios:f02f3bf6742996df5e4b8c',
    messagingSenderId: '521102319461',
    projectId: 'groceryproject-49143',
    storageBucket: 'groceryproject-49143.appspot.com',
    iosBundleId: 'com.example.myOwnGroceryApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBZRb_tiTcdWO9cDmasbPBYwjexe46-zKU',
    appId: '1:521102319461:ios:f02f3bf6742996df5e4b8c',
    messagingSenderId: '521102319461',
    projectId: 'groceryproject-49143',
    storageBucket: 'groceryproject-49143.appspot.com',
    iosBundleId: 'com.example.myOwnGroceryApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDBr8KAJwYppg7yzQQckXDiIQr0y4lc3B4',
    appId: '1:521102319461:web:97d494cadb01d58e5e4b8c',
    messagingSenderId: '521102319461',
    projectId: 'groceryproject-49143',
    authDomain: 'groceryproject-49143.firebaseapp.com',
    storageBucket: 'groceryproject-49143.appspot.com',
    measurementId: 'G-BDMPW7S3LK',
  );

}