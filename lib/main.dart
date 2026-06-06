import 'package:again_evently/core/routes/app_routes.dart';
import 'package:again_evently/core/routes/page_route_name.dart';
import 'package:again_evently/core/theme/app_theme.dart';
import 'package:again_evently/modules/provider/setting_provider.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'back_ground_handler.dart';
import 'core/services/f_c_m_service.dart';
import 'firebase_options.dart';
import 'l10n/app_localizations.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  final fcmService = FCMService();
  await fcmService.initialize();

  runApp(ChangeNotifierProvider(
    create: (context) => SettingProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late SettingProvider provider;

  @override
  void initState() {
    super.initState();
    _handleInitialNotification();
  }

  Future<void> _handleInitialNotification() async {
    Future.delayed(const Duration(seconds: 1), () {
      final fcmService = FCMService();
      fcmService.handleInitialMessage();
    });
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SettingProvider>(context);
    initSharedPref();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Evently',
      initialRoute: PageRouteName.initial,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      navigatorKey: navigatorKey,
      builder: (context, child) {
        child = EasyLoading.init()(context, child);
        child = BotToastInit()(context, child);
        return child;
      },
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: provider.currentTheme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(provider.currentLanguage),
    );
  }

  initSharedPref() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? lang = pref.getString('lang');
    String? theme = pref.getString('theme');
    provider.setLanguage(lang ?? 'ar');

    if (theme == 'dark') {
      provider.setCurrentTheme(ThemeMode.dark);
    } else if (theme == 'light') {
      provider.setCurrentTheme(ThemeMode.light);
    }
  }
}