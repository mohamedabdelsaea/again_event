// lib/background_handler.dart
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // ✅ مهم جداً: إعادة تهيئة Firebase في الـ Isolate الجديد
  await Firebase.initializeApp();

  log('📨 رسالة خلفية مستلمة:');
  log('العنوان: ${message.notification?.title}');
  log('النص: ${message.notification?.body}');
  log('البيانات: ${message.data}');

  // هنا يمكنك إضافة منطق خاص للمعالجة في الخلفية
  // مثل حفظ البيانات في local storage أو تحديث حالة التطبيق
}