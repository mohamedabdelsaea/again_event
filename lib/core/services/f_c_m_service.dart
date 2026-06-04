import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'local_notification_service.dart';

class FCMService {
  static final FCMService _instance = FCMService._internal();

  factory FCMService() => _instance;

  FCMService._internal();

  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final LocalNotificationService _localNotification =
      LocalNotificationService();

  static Future<void> _backgroundHandler(RemoteMessage message) async {
    debugPrint('معالج الخلفية: تم استلام رسالة');
    debugPrint('البيانات: ${message.data}');
  }

  Future<void> initialize() async {
    // 1. تهيئة الإشعارات المحلية
    await _localNotification.initialize();

    // 2. طلب الإذن (مطلوب في iOS و Android 13+)
    NotificationSettings settings = await _fcm.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false, // يسمح للمستخدم باختيار نوع الإشعارات لاحقًا
    );

    debugPrint('حالة الإذن: ${settings.authorizationStatus}');

    // 3. iOS: إعداد عرض الإشعارات في Foreground
    await _fcm.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // 4. الحصول على Token الجهاز (لإرسال الإشعارات له تحديدًا)
    String? token = await _fcm.getToken();
    debugPrint('📱 FCM Token: $token');

    // 5. مراقبة تحديثات Token
    _fcm.onTokenRefresh.listen((newToken) {
      debugPrint('🔄 تم تحديث Token: $newToken');
      // هنا يمكنك إرسال token الجديد للخادم الخاص بك
    });

    // 6. معالجة الرسائل في Foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('📨 رسالة في Foreground');

      // عرض الإشعار يدويًا (لأن FCM لا يعرضها في Foreground تلقائيًا)
      _showForegroundNotification(message);
    });

    // 7. معالجة فتح التطبيق من الإشعار (Background -> Foreground)
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);

    // 8. معالجة فتح التطبيق من حالة Terminated
    RemoteMessage? initialMessage = await _fcm.getInitialMessage();
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }
  }

  void _showForegroundNotification(RemoteMessage message) {
    final notification = message.notification;
    if (notification != null) {
      _localNotification.showNotification(
        id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
        title: notification.title ?? 'إشعار جديد',
        body: notification.body ?? '',
        payload: message.data.map((k, v) => MapEntry(k, v.toString())),
      );
    }
  }


  Future<void> handleInitialMessage() async {
    // معالجة الإشعار عندما يكون التطبيق مغلقاً تماماً (Terminated)
    RemoteMessage? initialMessage = await _fcm.getInitialMessage();
    if (initialMessage != null) {
      debugPrint('📱 تم فتح التطبيق من إشعار (Terminated state)');
      _handleMessage(initialMessage);
    }
  }

  void _handleMessage(RemoteMessage message) {
    debugPrint('👆 تم الضغط على الإشعار');
    debugPrint('البيانات: ${message.data}');

    // هنا يمكنك التنقل إلى الشاشة المناسبة بناءً على نوع الإشعار
    // مثال:
    // if (message.data['type'] == 'chat') {
    //   navigatorKey.currentState?.pushNamed('/chat', arguments: message.data['chatId']);
    // }
  }
}
