import 'package:again_evently/core/theme/app_color.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../../firebase_options.dart';

class FirebaseNotificationService {

  static late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  static late AndroidNotificationChannel channel;

  static bool isFlutterLocalNotificationsInitialized = false;

  static Future<void> backgroundHandler(RemoteMessage message) async {

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    await setupFlutterNotifications();

    showFlutterNotification(message);

    if (kDebugMode) {
      print('Handling a background message ${message.messageId}');
    }
  }

  static Future<void> setupFlutterNotifications() async {

    if (isFlutterLocalNotificationsInitialized) {
      return;
    }

    channel = const AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.high,
    );

    flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    isFlutterLocalNotificationsInitialized = true;
  }

  static void showFlutterNotification(RemoteMessage message) {

    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null && android != null && !kIsWeb) {

      flutterLocalNotificationsPlugin.show(
        id: notification.hashCode,
        title: notification.title,
        body: notification.body,
        notificationDetails: NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            icon: 'launch_background',
            importance: Importance.max,
            priority: Priority.high,
            color: AppColor.primary,
            enableVibration: true,
          ),
        ),
      );
    }
  }

  static Future<void> init() async {

    FirebaseMessaging.onBackgroundMessage(backgroundHandler);

    await setupFlutterNotifications();
  }
}