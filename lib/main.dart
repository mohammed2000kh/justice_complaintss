import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:justice_complaints/core/service/cache_helper.dart';
import 'package:justice_complaints/firebase_options.dart';
import 'package:justice_complaints/view/home_page.dart';
import 'package:justice_complaints/login/login_page.dart';
import 'package:justice_complaints/view/regester_page.dart';
import 'package:justice_complaints/view/waiting_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'controller/notifcation_controller.service.dart';
import 'core/constants/colors.dart';
import 'core/service/firebase_notifications_service.dart';

String initialRoute = '';
bool login = false;

String token = '';
// String username = '';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final notificationController = Get.put(NotificationController());

  login = await CacheHelper().getDataBool(key: 'login') ?? false;
  token = await CacheHelper().getDataString(key: 'token') ?? '';

  if (login) {
    initialRoute = '/home';
  } else if (notificationController.isAccountActivateWaiting.isTrue) {
    initialRoute = '/WaitingPage';
  } else {
    initialRoute = '/LoginPage';
  }

  await FirebaseNotificationsService().initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // print('token: $token');
    // initialRoute = '/LoginPage';
    // initialRoute = '/TestPage';
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      locale: const Locale('ar'),
      theme: ThemeData(
        fontFamily: 'Font',
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.mainColor),
        useMaterial3: true,
      ),
      supportedLocales: const [
        Locale('ar', ''),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      initialRoute: initialRoute,
      routes: {
        '/home': (context) => const HomePage(),
        '/LoginPage': (context) => LoginPage(),
        '/RegisterPage': (context) => RegisterPage(),
        '/WaitingPage': (context) => const WaitingPage(),
        // '/TestPage': (context) => const TestPage(),
      },
    );
  }
}
