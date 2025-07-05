import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:justice_complaints/view/home_page.dart';
import 'package:justice_complaints/view/test.dart';

import '../../../main.dart';
import '../core/service/cache_helper.dart';
import '../core/service/connect_api.dart';

class LoginController extends GetxController {
  // late RiveAnimationController controller;
  RxBool isPassword = true.obs;
  RxBool clip = true.obs;
  void changeIsPassword() {
    isPassword.value = !isPassword.value;
  }

  @override
  void onInit() {
    clip.value = true;
    super.onInit();
    // controller = OneShotAnimation(
    //   'Appearing',
    //   autoplay: true,
    //   onStart: () {
    //     Future.delayed(const Duration(milliseconds: 3450), () {
    //       controller.isActive = false;
    //     });
    //     Future.delayed(const Duration(milliseconds: 1500), () {
    //       clip.value = false;
    //     });
    //   },
    //   onStop: () {},
    // );
  }

  RxBool waitLogin = false.obs;

  void login(String userName, String password, context) async {
    waitLogin.value = true;
    await ApiServices().postLogin(
        url: 'Api/user/login',
        body: {"username": 'karzum', "password": '1234'}).then((value) {
      // print("tpken :${value.body[0]['token']}");
      if (value.statusCode == 200 &&
          value.bodyString != null &&
          value.bodyString!.isNotEmpty) {
        // print("value.body${value.body}");
        token = value.body[0]['token'].toString();
        // username = value.body[0]['name'].toString();

        waitLogin.value = false;
        // CacheHelper.saveData(key: 'port', value: port);
        // print(token);
        CacheHelper.saveData(key: 'token', value: token);
        // CacheHelper.saveData(key: 'username', value: username);
        CacheHelper.saveData(key: 'login', value: true);
        Get.offAll(() => HomePage());
      } else {
        waitLogin.value = false;
        message(context,
            txt: '${value.body != null ? value.bodyString : 'لا يوجد اتصال'}',
            icn: Icons.error_outline);
      }
    }).catchError((e) {
      print("e :$e");
      message(context, txt: '$e', icn: Icons.error_outline);
      waitLogin.value = false;
    });
  }
}

message(context, {required String txt, required IconData icn, Color? clr}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: clr,
      content: Row(
        children: [
          Icon(
            icn,
            color: Colors.white,
          ),
          const SizedBox(width: 8.0),
          Text(
            txt,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12.0,
            ),
          ),
        ],
      ),
      duration: const Duration(seconds: 2),
      action: SnackBarAction(
        label: 'إغلاق',
        textColor: Colors.white,
        onPressed: () {
          // إجراء عند النقر على الزر
        },
      ),
    ),
  );
}
