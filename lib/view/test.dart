// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controller/notifcation_controller.service.dart';
// import '../core/constants/colors.dart';
// import '../widgets/send_notefication.dart';

// class TestPage extends StatelessWidget {
//   const TestPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final notificationController = Get.find<NotificationController>();
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('تجربة إشعارات FCM'),
//         backgroundColor: AppColors.mainColor,
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               SelectableText(
//                 'توكن الجهاز:\n${notificationController.fcmToken}',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(color: AppColors.mainColor),
//               ),
//               const SizedBox(height: 30),
//               ElevatedButton(
//                 onPressed: () {
//                   sendNotification(
//                     token: notificationController.fcmToken ?? '',
//                     title: 'Hello Abdallah!',
//                     body: 'This is a new test notification.',
//                     data: {"route": "/product_details", "id": "120"},
//                   );
//                 },
//                 child: const Text('إرسال إشعار تجريبي'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
