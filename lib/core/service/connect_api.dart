import 'dart:io';

import 'package:get/get.dart';
import '../../main.dart';

class ApiServices extends GetConnect {
  RxBool? internetStatus;

  // bool? serverStatus;
  GetHttpClient getHttpClient = GetHttpClient(
    timeout: const Duration(seconds: 8),
  );
  // Future<bool> checkInternetConnection() async {
  //   try {
  //     // محاولة الاتصال بموقع موثوق
  //     final result = await InternetAddress.lookup('google.com')
  //         .timeout(const Duration(seconds: 4));
  //     if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
  //       // print('Internet connection is available');
  //       return true;
  //     }
  //   } catch (e) {
  //     // print('No internet connection: $e');
  //     return false;
  //   }
  //   return false;
  // }

  // Future<void> checkServerConnection() async {
  //   try {
  //     var response = await getHttpClient2
  //         .get('https://api.syriantec.com/scan_get_community', headers: {
  //       'token': '$token',
  //     });
  //     if (response.isOk) {
  //       print('Server connection is available');
  //       serverStatus = true;
  //     } else {
  //       serverStatus = false;
  //     }
  //   } catch (e) {
  //     serverStatus = false;
  //     print('No Server connection: $e');
  //   }
  // }

  Future<Response> getData({
    required String url,
  }) async {
    // print("before");
    // if (Get.find<HouseController>().internetStatus.value != true) {
    //   print(".......................");
    //   return Future.error(true);
    // }
    // print("after");
    var response =
        await getHttpClient.get('https://api-complaint.syriantec.com/$url', headers: {
      // 'Authorization': 'Bearer $token',
      //
      // "Accept":"application/json",
      'token': '15decc6c-6230-4aa3-baca-24cb4629e2cd',
      // 'nameedisblay':'human_scan'
      // "type": "apk"
      // "Content-Type":"application/json",
    });
    // print(response.body);
    // if (response.hasError) {
      // return Future.error(response.hasError);
    // } else {
      return response;
    // }
  }

  Future<Response> postData({
    required String url,
    // required int port,
    required dynamic body,
  }) async {
    // print("before");
    // if (Get.find<HouseController>().internetStatus.value != true) {
    //   print(".......................");
    //   return Future.error(Exception('لا يوجد اتصال بالإنترنت'));
    // }
    // print("after");
    final response = await getHttpClient.post(
      'https://api-complaint.syriantec.com/$url',
      headers: {
        'token': '$token',
        // 'nameedisblay':'human_scan'
        //   'Authorization': 'Bearer $token',
        // "Accept":"application/json",
        // "Content-Type": "application/json",
      },
      body: body,
    );
    // print(response.body);
    // if (response.hasError) {
      // print('responseError : ${response.statusText}');
      // print('responseErrorCodes : ${response.statusCode}');
      // print('responseErrorCode : ${response.statusCode}');
      // printLargeString(body.toString());
      // return response;
    // } else {
      // print("response : ${response.statusCode}");
      // printLargeString(body.toString());
      return response;
    // }
  }

  Future<Response> postLogin({
    required String url,
    // required int port,
    required Map<String, dynamic> body,
  }) async {
    // print("after");
    final response = await httpClient.post(
      'https://api-complaint.syriantec.com/$url',
      headers: {
        'token': '$token',
        //  'nameedisblay': 'human_scan'
        //   'Authorization': 'Bearer $token',
        // "Accept":"application/json",
        // "Content-Type": "application/json",
      },
      body: body,
    );
    // print(response.body);
    if (response.hasError) {
      print(body);
      return response;
    } else {
      print("response : ${response.statusCode}");
      return response;
    }
  }

  // Future<Response> check() async {
  //   // print('b');
  //   var response = await getHttpClient.get(
  //     'https://api.syriantec.com/scan_get_human_version',
  //     headers: {
  //       // 'Authorization': 'Bearer $token',
  //       //
  //       // "Accept":"application/json",
  //       'token': '$token',
  //       // 'nameedisblay': 'human_scan'

  //       // "Content-Type":"application/json",
  //     },
  //   );
  //   // print(response.body.toString());
  //   if (response.hasError) {
  //     return Future.error(response.hasError);
  //   } else {
  //     return response;
  //   }
  // }
}
