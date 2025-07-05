import 'package:get/get.dart';
import 'package:justice_complaints/core/service/cache_helper.dart';
import 'package:justice_complaints/main.dart';
import 'package:justice_complaints/view/home_page.dart';

import '../view/waiting_page.dart';

class NotificationController extends GetxController {
  String? fcmToken;
  RxBool isAccountActivateWaiting = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadActivationStatus();
  }

  Future<void> loadActivationStatus() async {
    bool? status = await CacheHelper().getDataBool(key: 'isAccountActivateWaiting');
    isAccountActivateWaiting.value = status ?? false;
  }
  void getWait(){
    isAccountActivateWaiting.value = true;
    CacheHelper.saveData(key: 'isAccountActivateWaiting', value: true);
    Get.offAll(() => const WaitingPage());
  }

  void activateAccount() {
    isAccountActivateWaiting.value = false;
    login = true;
    CacheHelper.saveData(key: 'login', value: true);
    CacheHelper.saveData(key: 'isAccountActivateWaiting', value: false);
    Get.offAll(() => const HomePage());
  }
}
