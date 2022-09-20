import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class MessagingService {
  static final _messaging = FirebaseMessaging.instance;
  static final _firestore = FirebaseFirestore.instance;
  static late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
  static late AndroidNotificationChannel _channel;

  static Future<void> initialize() async {
    _channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description: 'This channel is used for important notifications.',
      // description
      importance: Importance.max,
    );
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel);

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    listenForegroundMessage();
  }

  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.
    await Firebase.initializeApp();
  }

  static Future<void> getNotificationToken(String userId) async {
    final token = await _messaging.getToken();
    if (token != null) {
      await _firestore.collection('users').doc(userId).update({
        'notificationToken': token,
      });
    }
  }

  static void listenForegroundMessage() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _flutterLocalNotificationsPlugin.show(
          1,
          message.notification?.title ?? 'New notification',
          message.notification?.body ?? 'Check To Do Serverless app',
          NotificationDetails(
            android: AndroidNotificationDetails(
              _channel.id,
              _channel.name,
              channelDescription: _channel.description,
              playSound: true,
              icon: '@mipmap/ic_launcher',
            ),
          ));
    });
  }
}
