import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:justice_complaints/model/governorates.module.dart';
import '../controller/register_controller.service.dart';
import '../model/communities.module.dart';
import '../model/districts.module.dart';
import '../model/subdistricts.module.dart';
import 'methods.dart';
import 'searchbar_app.dart';

void getPlaceDialog({
  required BuildContext context,
  required RegisterController registerController,
}) {
  RxString place = ''.obs;
  RxInt selectedGovernorate = registerController.selectedGovernorate;
  RxInt selectedDistrict = registerController.selectedDistrict;
  RxInt selectedSubDistrict = registerController.selectedSubDistrict;
  RxInt selectedCommunity = registerController.selectedCommunity;

  void resetSelectionsAfterGovernorateChange() {
    selectedDistrict.value = -1;
    selectedSubDistrict.value = -1;
    selectedCommunity.value = -1;
  }

  void resetSelectionsAfterDistrictChange() {
    selectedSubDistrict.value = -1;
    selectedCommunity.value = -1;
  }

  void resetSelectionsAfterSubDistrictChange() {
    selectedCommunity.value = -1;
  }

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('اختيار المكان'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(
                () => SearchBarApp(
                  label: 'المحافظات',
                  list: registerController.governorates,
                  // req:RxBool( req.value),
                  initialId: selectedGovernorate.value,
                  onChanged: ({required object}) {
                    if (object is GovernoratesModel) {
                      selectedGovernorate.value = object.id;
                      // selectedGovernorateName.value = object.name;
                      resetSelectionsAfterGovernorateChange();
                    }
                  },
                ),
              ),
              Obx(
                () => SearchBarApp(
                  label: 'المناطق',
                  list: registerController.districts
                      .where((element) =>
                          element.governorateId == selectedGovernorate.value)
                      .toList()
                      .obs,
                  initialId: selectedDistrict.value,
                  onChanged: ({required object}) {
                    if (object is DistrictsModel) {
                      selectedDistrict.value = object.id;
                      resetSelectionsAfterDistrictChange();
                    }
                  },
                ),
              ),
              Obx(
                () => SearchBarApp(
                  label: 'الناحيات',
                  list: registerController.subdistricts
                      .where((element) =>
                          element.districtId == selectedDistrict.value)
                      .toList()
                      .obs,
                  initialId: selectedSubDistrict.value,
                  onChanged: ({required object}) {
                    if (object is SubDistrictsModel) {
                      selectedSubDistrict.value = object.id;
                      resetSelectionsAfterSubDistrictChange();
                    }
                  },
                ),
              ),
              Obx(
                () => SearchBarApp(
                  label: 'البلدات',
                  list: registerController.community
                      .where((element) =>
                          element.subDistrictId == selectedSubDistrict.value)
                      .toList()
                      .obs,
                  initialId: selectedCommunity.value,
                  onChanged: ({required object}) {
                    if (object is CommunitiesModel) {
                      selectedCommunity.value = object.id;
                      place.value = object.code ?? '';
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            child: const Text('إلغاء'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('حفظ'),
            onPressed: () {
              if (selectedCommunity.value == -1 ||
                  selectedDistrict.value == -1 ||
                  selectedSubDistrict.value == -1 ||
                  selectedCommunity.value == -1) {
                messageGet(
                  txt: 'يرجى تحديد جميع القيم قبل الحفظ',
                  icn: Icons.error,
                  title: 'خطأ',
                );
              } else {
                Navigator.of(context).pop();
                registerController.selectedPlace.value = place.string;
              }
            },
          ),
        ],
      );
    },
  );
}
