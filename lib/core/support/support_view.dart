// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:lottie/lottie.dart';
// import 'package:dio/dio.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:path_provider/path_provider.dart';
// import 'dart:io';
// import 'package:open_file/open_file.dart';

// import '../../../main.dart';
// import '../constants/colors.dart';
// import 'version.dart';

// class SupportPage extends StatefulWidget {
//   final String version;
//   const SupportPage({super.key, required this.version});

//   @override
//   _SupportPageState createState() => _SupportPageState();
// }

// class _SupportPageState extends State<SupportPage> {
//   Dio dio = Dio();
//   String apkUrl = 'https://api.syriantec.com/downloadFile/place_scan.apk';
//   RxDouble downloadProgress = 0.0.obs;

//   @override
//   void initState() {
//     super.initState();
//   }

//   // التحقق من إذن التخزين
//   Future<bool> checkStoragePermission() async {
//     var status = await Permission.manageExternalStorage.request();
//     return status.isGranted;
//   }

//   Future<void> requestInstallPermission() async {
//     var status = await Permission.requestInstallPackages.request();

//     if (status.isGranted) {
//       print('Install permission granted');
//     } else {
//       print('Install permission denied');
//     }
//   }

//   // تنزيل التطبيق
//   Future<void> downloadApk() async {
//     try {
//       bool permissionGranted = await checkStoragePermission();
//       if (!permissionGranted) {
//         print('Storage permission not granted');
//         return;
//       }

//       String filePath = await getFilePath();

//       dio.options.headers = {
//         'token': '$token', // إضافة التوكن إلى الترويسات
//       };

//       await dio.download(
//         apkUrl,
//         filePath,
//         onReceiveProgress: (received, total) {
//           setState(() {
//             downloadProgress.value = (received / total) * 100;
//           });
//         },
//       );

//       print('Download complete: $filePath');
//       await installApk(filePath);
//     } catch (e) {
//       print('Error downloading APK: $e');
//     }
//   }

//   // الحصول على مسار حفظ الملف
//   Future<String> getFilePath() async {
//     Directory? directory = await getExternalStorageDirectory();
//     return '${directory!.path}/app-update.apk';
//   }

//   // تثبيت التطبيق
//   Future<void> installApk(String filePath) async {
//     try {
//       if (Platform.isAndroid) {
//         await requestInstallPermission();
//         // احصل على URI باستخدام FileProvider
//         final file = File(filePath);
//         if (file.existsSync()) {
//           var a = await OpenFile.open(file.path);
//           print("a:${a.message}");
//         }
//       } else {
//         print('Installation is only supported on Android');
//       }
//     } catch (e) {
//       print('Error installing APK: $e');
//     }
//   }

//   // التحقق من وجود تحديث
//   Future<void> checkAndDownloadUpdate() async {
//     // يمكنك إضافة كود التحقق من التحديث هنا
//     await downloadApk();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           backgroundColor: AppColors.mainColor,
//           title: const Text(
//             'مسح مكاني',
//             style: TextStyle(color: AppColors.white, fontSize: 20),
//           ),
//           centerTitle: true,
//           leading: const SizedBox(),
//         ),
//         body: Directionality(
//             textDirection: TextDirection.rtl,
//             child: Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Spacer(
//                         flex: 2,
//                       ),
//                       Center(
//                         child: Lottie.asset('assets/images/about.json',
//                             height: 250),
//                       ),
//                       const SizedBox(height: 50),
//                       Container(
//                         // color: Colors.amber,
//                         child: Column(
//                           children: [
//                             Container(
//                               // color: Colors.red,
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   const Text('تم رفع اصدار جديد من التطبيق: '),
//                                   InkWell(
//                                     onTap: () async {
//                                       checkAndDownloadUpdate();
//                                       Get.defaultDialog(
//                                           title: 'جار تحديث التطبيق',
//                                           content: Obx(() {
//                                             return Material(
//                                               child: Column(
//                                                 children: [
//                                                   Text(
//                                                       '${downloadProgress.value.toStringAsFixed(1)}%'),
//                                                   LinearProgressIndicator(
//                                                     value:
//                                                         downloadProgress.value /
//                                                             100,
//                                                   ),
//                                                 ],
//                                               ),
//                                             );
//                                           }));
//                                     },
//                                     child: const Text(
//                                       'اضغط للتحميل',
//                                       style: TextStyle(
//                                         color: Colors.blue,
//                                       ),
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                             SizedBox(height: 20),
//                           ],
//                         ),
//                       ),
//                       Spacer(
//                         flex: 2,
//                       ), // هذه تجعل العنصر التالي يذهب للأسفل
//                       Container(
//                         decoration: BoxDecoration(
//                             color: AppColors.mainColor2,
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(25))),
//                         padding: EdgeInsets.all(10),
//                         width: double.infinity,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text('الإصدار الحالي : $versionNumber '),
//                             Text('الإصدار المطلوب : ${widget.version} '),
//                           ],
//                         ),
//                       ),
//                     ]))));
//   }
// }
