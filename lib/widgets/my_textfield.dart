import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key,
    required this.controller,
    required this.labelText,
  });

  final RxString controller;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    final RxBool isEdited = false.obs; // متابعة ما إذا تم تعديل النص
    return Obx(
      () => TextField(
        controller: TextEditingController(text: controller.value)
          ..selection = TextSelection.fromPosition(TextPosition(
              offset: controller.value.length)), // لحفظ موضع المؤشر
        onChanged: (value) {
          controller.value = value;
          isEdited.value = true; // تحديد أن المستخدم أدخل قيمة
        },
        decoration: InputDecoration(
          labelText: labelText,
          errorText: isEdited.value &&
                  controller.value.trim().length < 2 &&
                  labelText != 'الملاحظات'
              ? 'يجب أن يكون المحتوى أكثر من حرف'
              : null,
        ),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[ء-ي\s]'))
        ],
      ),
    );
  }
}
