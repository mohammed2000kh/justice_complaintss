import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// void printLargeString(String text, {int chunkSize = 800}) {
//   int startIndex = 0;
//   while (startIndex < text.length) {
//     int endIndex = startIndex + chunkSize;
//     if (endIndex > text.length) {
//       endIndex = text.length;
//     }
//     print(text.substring(startIndex, endIndex));
//     startIndex = endIndex;
//   }
// }
// String parseError(dynamic e) {
//   if (e is Exception) {
//     return e.toString().replaceAll('Exception:', '');
//   }
//   return e.toString();
// }

// }
// // messae(context,
// //     {required String txt,
// //     required IconData icn,
// //     Color? clr,
// //     required String title}) {
// //   return ScaffoldMessenger.of(context).showSnackBar(
// //     SnackBar(
// //       backgroundColor: clr,
// //       content: Row(
// //         children: [
// //           Icon(
// //             icn,
// //             color: Colors.white,
// //           ),
// //           const SizedBox(width: 8.0),
// //           Text(
// //             txt,
// //             style: const TextStyle(
// //               color: Colors.white,
// //               fontSize: 12.0,
// //             ),
// //           ),
// //         ],
// //       ),
// //       duration: const Duration(seconds: 2),
// //       action: SnackBarAction(
// //         label: 'إغلاق',
// //         textColor: Colors.white,
// //         onPressed: () {
// //           // إجراء عند النقر على الزر
// //         },
// //       ),
// //     ),
// //   );
// // }
void messageGet(
    {required String title, required String txt, IconData? icn, Color? clr}) {
  Get.snackbar(title, txt,
      icon: Icon(icn), backgroundColor: clr ?? Colors.white);
  // ScaffoldMessenger.of(context).showSnackBar(
  //   SnackBar(
  //     backgroundColor: clr ?? Colors.black,
  //     content: Row(
  //       children: [
  //         Icon(
  //           icn,
  //           color: Colors.white,
  //         ),
  //         const SizedBox(width: 8.0),
  //         Text(
  //           txt,
  //           style: const TextStyle(
  //             color: Colors.white,
  //             fontSize: 12.0,
  //           ),
  //         ),
  //       ],
  //     ),
  //     duration: const Duration(seconds: 2),
  //     action: SnackBarAction(
  //       label: 'إغلاق',
  //       textColor: Colors.white,
  //       onPressed: () {
  //         // يمكنك تنفيذ أي إجراء هنا عند النقر على الزر
  //       },
  //     ),
  //   ),
  // );
}

void AwesomeD({
  required BuildContext ctx,
  required Function okF,
  // required Function cnclF,
  required String title,
  String? message,
  // required String ok,
  // required String cncl,
}) {
  showCupertinoDialog(
    context: ctx,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: Text(title),
        content: Text(message ?? ''),
        actions: [
          Container(
            color: Colors.green.shade200,
            child: CupertinoDialogAction(
              onPressed: () {
                Navigator.pop(context);
                okF();
              },
              child: const Text("موافق"),
            ),
          ),
          Container(
            color: Colors.red.shade200,
            child: CupertinoDialogAction(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("إلغاء"),
            ),
          ),
        ],
      );
    },
  );
}

  // AwesomeDialog(
  //   context: ctx,
  //   title: title,
  //   desc: message,
  //   btnOkOnPress: () => okF(),
  //   btnCancelOnPress: () {},
  //   btnOkText: 'موافق',
  //   btnCancelText: 'إلغاء',
  //   dialogType: dialogType,
  // ).show();