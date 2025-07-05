import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import '../../controller/notifcation_controller.service.dart';

const AndroidNotificationChannel justiceChannel = AndroidNotificationChannel(
  'justice_channel',
  'justice_channel Notifications',
  description: 'Used for important notifications.',
  importance: Importance.max,
  playSound: true,
  enableVibration: true,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class FirebaseNotificationsService {
  final NotificationController notificationController = Get.find();

  Future<void> initialize() async {
    await _createNotificationChannel();
    await _initializeLocalNotifications();
    await _setupFirebaseMessageHandlers();
    await requestPermission();
    await getToken();
    await checkInitialMessage();
  }

  Future<void> _createNotificationChannel() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(justiceChannel);
  }

  Future<void> _initializeLocalNotifications() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    final settings = InitializationSettings(android: androidSettings);

    await flutterLocalNotificationsPlugin.initialize(
      settings,
      // onDidReceiveNotificationResponse: (response) {
      //   final payload = response.payload;
      // },
    );
  }

  Future<void> _setupFirebaseMessageHandlers() async {
    FirebaseMessaging.onMessage.listen(_onMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenedApp);
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }

  Future<void> requestPermission() async {
    final settings = await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      // print('✅ Notification permission granted');
    } else {
      // print('❌ Notification permission denied');
    }
  }

  Future<void> getToken() async {
    final token = await FirebaseMessaging.instance.getToken();
    // print('📱 FCM Token: $token');
    notificationController.fcmToken = token;
  }

  Future<void> checkInitialMessage() async {
    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      handleNotificationAction(initialMessage);
    }
  }

  Future<void> _onMessage(RemoteMessage message) async {
    await showNotification(message);

    final activateStatus = message.data['activateStatus'];
    if (notificationController.isAccountActivateWaiting.isTrue &&
        activateStatus == 'success') {
      notificationController.activateAccount();
    }
  }

  Future<void> _onMessageOpenedApp(RemoteMessage message) async {
    handleNotificationAction(message);
  }

  void handleNotificationAction(RemoteMessage message) {
    final activateStatus = message.data['activateStatus'];
    if (notificationController.isAccountActivateWaiting.isFalse &&
        activateStatus == 'success') {
      notificationController.activateAccount();
    }
  }

  Future<void> showNotification(RemoteMessage message) async {
    final notification = message.notification;
    final android = message.notification?.android;

    if (notification != null && android != null) {
      await flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title ?? 'No Title',
        notification.body ?? 'No Body',
        NotificationDetails(
          android: AndroidNotificationDetails(
            justiceChannel.id,
            justiceChannel.name,
            channelDescription: justiceChannel.description,
            importance: Importance.max,
            priority: Priority.high,
            playSound: true,
            enableVibration: true,
            icon: '@mipmap/ic_launcher',
          ),
        ),
        payload: message.data['activateStatus'],
      );
    }
  }
}
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  // print('🔔 Background notification: ${message.notification?.title} - ${message.notification?.body}');
}
