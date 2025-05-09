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
    apiKey: 'AIzaSyCJieYxrCCZK9SvE6HJpRNHrfHGvFnjOfQ',
    appId: '1:309718406483:web:fd746ff49fd18e49d3fda6',
    messagingSenderId: '309718406483',
    projectId: 'cmsc23-project-c0452',
    authDomain: 'cmsc23-project-c0452.firebaseapp.com',
    storageBucket: 'cmsc23-project-c0452.appspot.com',
    measurementId: 'G-CHHH33LXNC',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBfBj0-uvmJ3hPgo9-k2U85EXfz-7snI5k',
    appId: '1:309718406483:android:36c1f98659299b96d3fda6',
    messagingSenderId: '309718406483',
    projectId: 'cmsc23-project-c0452',
    storageBucket: 'cmsc23-project-c0452.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCc8Z8APYyrRHk6pYi54l85ihlskzrTFb0',
    appId: '1:309718406483:ios:20d2b90f042e65b6d3fda6',
    messagingSenderId: '309718406483',
    projectId: 'cmsc23-project-c0452',
    storageBucket: 'cmsc23-project-c0452.appspot.com',
    iosClientId: '309718406483-to0pau0n6i7qo73v1hgoda94k54mqoqi.apps.googleusercontent.com',
    iosBundleId: 'com.example.amanteContaoiNoveloOlipas',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCc8Z8APYyrRHk6pYi54l85ihlskzrTFb0',
    appId: '1:309718406483:ios:888e89895dd52985d3fda6',
    messagingSenderId: '309718406483',
    projectId: 'cmsc23-project-c0452',
    storageBucket: 'cmsc23-project-c0452.appspot.com',
    iosClientId: '309718406483-vfpuvt3ctdq1p8oq9i0q00a33496t06d.apps.googleusercontent.com',
    iosBundleId: 'com.example.amanteContaoiNoveloOlipas.RunnerTests',
  );
}
