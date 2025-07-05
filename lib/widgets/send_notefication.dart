// import 'dart:convert';
// import 'package:flutter/services.dart';
// import 'package:http/http.dart' as http;
// import 'package:googleapis_auth/auth_io.dart' as auth;
// // import 'package:send_notification_example/product_details_screen.dart';

// Future<String> getAccessToken() async {
//   final jsonString = await rootBundle.loadString(
//     'assets/key/justice-b9f4a-38d2a1fe5e5d.json',
//   );

//   final accountCredentials =
//       auth.ServiceAccountCredentials.fromJson(jsonString);

//   final scopes = ['https://www.googleapis.com/auth/firebase.messaging'];
//   final client = await auth.clientViaServiceAccount(accountCredentials, scopes);

//   return client.credentials.accessToken.data;
// }

// Future<void> sendNotification({
//   required String token,
//   required String title,
//   required String body,
//   required Map<String, String> data,
// }) async {
//   final String accessToken = await getAccessToken();
//   print(
//       '//////////////////////////////////////////////////////////////////////');
//   print('Access Token: $accessToken');

//   final String fcmUrl =
//       'https://fcm.googleapis.com/v1/projects/justice-b9f4a/messages:send';

//   data.putIfAbsent('activateStatus', () => 'success');

//   final response = await http.post(
//     Uri.parse(fcmUrl),
//     headers: <String, String>{
//       'Content-Type': 'application/json',
//       'Authorization': 'Bearer $accessToken',
//     },
//     body: jsonEncode(<String, dynamic>{
//       'message': {
//         'token': token,
//         'notification': {
//           'title': title,
//           'body': body,
//         },
//         'data': data,
//         'android': {
//           'notification': {
//             'sound': 'custom_sound',
//             'click_action': 'FLUTTER_NOTIFICATION_CLICK',
//             'channel_id': 'high_importance_channel',
//           },
//         },
//         'apns': {
//           'payload': {
//             'aps': {
//               'sound': 'custom_sound.caf',
//               'content-available': 1,
//             },
//           },
//         },
//       },
//     }),
//   );

//   if (response.statusCode == 200) {
//     print('✅ Notification sent successfully');
//   } else {
//     print('❌ Failed to send notification: ${response.body}');
//   }
// }

// // void handleNotification(BuildContext context, Map<String, dynamic> data) {
// //   String route = data['route'];
// //   String id = data['id'];

// //   if (route == '/product_detials') {
// //     Navigator.push(
// //       context,
// //       MaterialPageRoute(
// //           builder: (context) => ProductDetailsScreen(productId: id)),
// //     );
// //   }
// // }
