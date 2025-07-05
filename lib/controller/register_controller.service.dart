import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:justice_complaints/core/utils/files.dart';
import 'package:justice_complaints/model/communities.module.dart';
import 'package:justice_complaints/model/districts.module.dart';
import 'package:justice_complaints/view/waiting_page.dart';

import '../core/service/connect_api.dart';
import '../main.dart';
import '../model/governorates.module.dart';
import '../model/subdistricts.module.dart';
import '../model/user.module.dart';
import '../widgets/methods.dart';
import 'notifcation_controller.service.dart';

class RegisterController extends GetxController {
  final notificationController = Get.find<NotificationController>();
  @override
  void onInit() {
    if (login == true) {
      reload.value = false;
    }
    getgovernoratesList();
    getdistrictsList();
    getCommunitiesList();
    getsubdistrictsList();
    super.onInit();
  }

  RxBool reload = true.obs;
  RxList<GovernoratesModel> governorates =
      <GovernoratesModel>[].obs; //المحافظات
  RxList<DistrictsModel> districts = <DistrictsModel>[].obs; //المناطق
  RxList<SubDistrictsModel> subdistricts = <SubDistrictsModel>[].obs; //الناحيات
  RxList<CommunitiesModel> community = <CommunitiesModel>[].obs; //البلدات

  //////////////
  RxInt selectedGovernorate = (-1).obs;
  RxInt selectedDistrict = (-1).obs;
  RxInt selectedSubDistrict = (-1).obs;
  RxInt selectedCommunity = (-1).obs;
  // بيانات المستخدم (RxString)
  final firstName = ''.obs;
  final lastName = ''.obs;
  final fatherName = ''.obs;
  final motherName = ''.obs;
  final birthDate = ''.obs;
  final birthPlace = ''.obs;
  final nationalId = TextEditingController();
  final identityNumber = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  RxString selectedPlace = ''.obs;
  final address = ''.obs;
  final email = TextEditingController();
  final emailText = ''.obs;
  final username = TextEditingController();
  final password = ''.obs;
  final confirmPassword = ''.obs;
  final obscurePassword = true.obs;
  final obscureConfirmPassword = true.obs;
  // RxBool req = false.obs;

  // صور
  final idFrontImage = Rxn<File>();
  final idBackImage = Rxn<File>();

  Future<void> pickImage(Rxn<File> target) async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      target.value = File(picked.path);
    }
  }

  Future<void> getgovernoratesList() async {
    try {
      if (!reload.value) {
        throw Exception('ملفات التخزين');
      }
      final response =
          await ApiServices().getData(url: 'Api/loction/governorates');

      if (response.statusCode == 200 && response.body != null) {
        governorates.value = List<GovernoratesModel>.from(
          (jsonDecode(response.bodyString!) as List)
              .map((e) => GovernoratesModel.fromJson(e)),
        );
        saveGovernoratesToFile(governorates);
      } else {
        throw Exception('${response.body}');
      }
    } catch (e) {
      try {
        governorates.value = await loadGovernoratesFromFile();
      } catch (e2) {
        print('Error loading community data: $e2');
      }
      if (governorates.isEmpty) {
        messageGet(
          title: 'خطأ',
          txt: 'حدث خطأ أثناء تحميل المحاضر:\n $e',
          icn: Icons.error_outline,
        );
      }
    }
  }

  Future<void> getdistrictsList() async {
    try {
      if (!reload.value) {
        throw Exception('ملفات التخزين');
      }
      final response =
          await ApiServices().getData(url: 'Api/loction/districts');

      if (response.statusCode == 200 && response.body != null) {
        districts.value = List<DistrictsModel>.from(
          (jsonDecode(response.bodyString!) as List)
              .map((e) => DistrictsModel.fromJson(e)),
        );
        saveDistrictsToFile(districts);
      } else {
        throw Exception('${response.body}');
      }
    } catch (e) {
      try {
        districts.value = await loadDistrictsFromFile();
      } catch (e2) {
        print('Error loading districts data: $e2');
      }
      if (districts.isEmpty) {
        // messageGet(
        //   title: 'خطأ',
        //   txt: 'حدث خطأ أثناء تحميل المحاضر:\n $e',
        //   icn: Icons.error_outline,
        // );
      }
    }
  }

  Future<void> getsubdistrictsList() async {
    try {
      if (!reload.value) {
        throw Exception('ملفات التخزين');
      }
      final response =
          await ApiServices().getData(url: 'Api/loction/subdistricts');

      if (response.statusCode == 200 && response.body != null) {
        subdistricts.value = List<SubDistrictsModel>.from(
          (jsonDecode(response.bodyString!) as List)
              .map((e) => SubDistrictsModel.fromJson(e)),
        );
        saveSubDistrictsToFile(subdistricts);
      } else {
        throw Exception('${response.body}');
      }
    } catch (e) {
      try {
        subdistricts.value = await loadSubDistrictsFromFile();
      } catch (e2) {
        print('Error loading subdistricts data: $e2');
      }
      if (subdistricts.isEmpty) {
        // messageGet(
        //   title: 'خطأ',
        //   txt: 'حدث خطأ أثناء تحميل المحاضر:\n $e',
        //   icn: Icons.error_outline,
        // );
      }
    }
  }

  Future<void> getCommunitiesList() async {
    try {
      if (!reload.value) {
        throw Exception('ملفات التخزين');
      }
      final response =
          await ApiServices().getData(url: 'Api/loction/communities');

      if (response.statusCode == 200 && response.body != null) {
        community.value = List<CommunitiesModel>.from(
          (jsonDecode(response.bodyString!) as List)
              .map((e) => CommunitiesModel.fromJson(e)),
        );
        saveCommunityToFile(community);
      } else {
        throw Exception('${response.body}');
      }
    } catch (e) {
      try {
        community.value = await loadCommunityFromFile();
      } catch (e2) {
        print('Error loading community data: $e2');
      }
      if (community.isEmpty) {
        // messageGet(
        //   title: 'خطأ',
        //   txt: 'حدث خطأ أثناء تحميل المحاضر:\n $e',
        //   icn: Icons.error_outline,
        // );
      }
    }
  }

  Future<void> sendRegisterData() async {
    try {
      // قراءة الصور وتحويلها إلى base64
      String photoBase64 = '';
      String photo2Base64 = '';
      if (idFrontImage.value != null) {
        final bytes = await idFrontImage.value!.readAsBytes();
        photoBase64 = 'data:image/png;base64,${base64Encode(bytes)}';
      }
      if (idBackImage.value != null) {
        final bytes = await idBackImage.value!.readAsBytes();
        photo2Base64 = 'data:image/png;base64,${base64Encode(bytes)}';
      }

      // إنشاء كائن المستخدم
      UserModel user = UserModel(
        firstName: firstName.value,
        lastName: lastName.value,
        fatherName: fatherName.value,
        matherName: motherName.value,
        username: username.text,
        password: password.value,
        numNational: nationalId.text,
        idNumber: identityNumber.text,
        phone: phoneController.text,
        gmail: email.text,
        placeCode: selectedPlace.value,
        address: address.value,
        deviceTokenp: Get.find<NotificationController>().fcmToken ?? '',
        photo: photoBase64,
        photo2: photo2Base64,
      );
      print(user.toJson());

      // final body = {
      //   "first_name": "بلال",
      //   "last_name": "الشمري",
      //   "father_name": "خالد",
      //   "mather_name": "سعاد",
      //   "username": "ahmad3ddee.sh",
      //   "password": "secur3e123",
      //   "num_national": "987654321",
      //   "id_number": "ID123456789",
      //   "phone": "+46728385969",
      //   "gmail": "ahaam6aed@gmail.com",
      //   "place_code": "BG123555555555555",
      //   "device_tokenp": "fgjklgkjljkl",
      //   "photo": "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAUA...",
      //   "photo2": "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAUB..."
      // };

      final response = await ApiServices().postData(
        url: 'Api/user/create',
        // body: body,
        body: user.toJson(),
      );

      if (response.statusCode == 200) {
        Get.snackbar('نجاح', 'تم إرسال بيانات الحساب بنجاح',
            backgroundColor: Colors.green[100], colorText: Colors.black);
        notificationController.getWait();
      } else {
        Get.snackbar('خطأ', 'فشل في إنشاء الحساب: ${response.bodyString}');
      }
    } catch (e) {
      Get.snackbar('خطأ', 'حدث خطأ أثناء الإرسال: $e');
    }
  }

  Future<void> submitForm() async {
    List<String> missingFields = [];

    if (firstName.value.trim().length < 2) missingFields.add("الاسم");
    if (lastName.value.trim().length < 2) missingFields.add("النسبة");
    if (fatherName.value.trim().length < 2) missingFields.add("اسم الأب");
    if (motherName.value.trim().length < 2) missingFields.add("اسم الأم");
    if (birthDate.value.trim().length < 2) missingFields.add("تاريخ الميلاد");
    if (selectedPlace.value.trim().length < 2)
      missingFields.add("معلومات المكان");
    if (address.value.trim().length < 2) missingFields.add("العنوان");
    if (birthPlace.value.trim().length < 2) missingFields.add("مكان الولادة");
    if (nationalId.text.trim().length < 2) missingFields.add("الرقم الوطني");
    if (identityNumber.text.trim().length < 2) missingFields.add("رقم الهوية");
    if (phoneController.text.trim().length < 6) missingFields.add("رقم الهاتف");
    if (email.text.trim().length < 2) missingFields.add("البريد الإلكتروني");
    if (username.text.trim().length < 2) missingFields.add("اسم المستخدم");
    if (password.value.trim().length < 2) missingFields.add("كلمة السر");
    if (confirmPassword.value.trim().length < 2) {
      missingFields.add("تأكيد كلمة السر");
    }

    if (idFrontImage.value == null) missingFields.add("صورة الهوية الأمامية");
    if (idBackImage.value == null) missingFields.add("صورة الهوية الخلفية");

    if (password.value != confirmPassword.value) {
      Get.snackbar('خطأ', 'كلمة السر وتأكيدها غير متطابقتين');
      return;
    }

    if (missingFields.isNotEmpty) {
      String message =
          "يرجى تعبئة الحقول التالية:\n• ${missingFields.join("\n• ")}";
      Get.snackbar(
        'بيانات ناقصة',
        message,
        duration: Duration(seconds: 5),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[100],
        colorText: Colors.black,
      );
      return;
    }
    await sendRegisterData();
  }
}
