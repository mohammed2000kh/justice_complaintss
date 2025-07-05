// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// @pragma('vm:entry-point')
// Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   print('//backkkk');
//   await Firebase.initializeApp();

//   final notification = message.notification;
//   final android = message.notification?.android;

//   // if (notification != null && android != null) {
//   //   final FlutterLocalNotificationsPlugin flnp =
//   //       FlutterLocalNotificationsPlugin();
//   //   const AndroidNotificationChannel backgroundChannel =
//   //       AndroidNotificationChannel(
//   //     'background_channel',
//   //     'خلفية',
//   //     description: 'إشعارات في الخلفية',
//   //     importance: Importance.high,
//   //   );

//   //   await flnp
//   //       .resolvePlatformSpecificImplementation<
//   //           AndroidFlutterLocalNotificationsPlugin>()
//   //       ?.createNotificationChannel(backgroundChannel);

//   //   await flnp.show(
//   //     notification.hashCode,
//   //     notification.title,
//   //     notification.body,
//   //     NotificationDetails(
//   //       android: AndroidNotificationDetails(
//   //         backgroundChannel.id,
//   //         backgroundChannel.name,
//   //         channelDescription: backgroundChannel.description,
//   //         icon: '@mipmap/ic_launcher',
//   //         importance: Importance.high,
//   //         priority: Priority.high,
//   //       ),
//   //     ),
//   //     payload: message.data['activateStatus'],
//   //   );
//   // }
// }
