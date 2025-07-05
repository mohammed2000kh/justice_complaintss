import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:justice_complaints/core/constants/colors.dart';
import 'package:justice_complaints/widgets/methods.dart';
import 'package:justice_complaints/widgets/widgets.dart';
import '../widgets/getplace_widget.dart';
import '../widgets/my_textfield.dart';
import '../controller/register_controller.service.dart';

class RegisterPage extends StatelessWidget {
  final controller = Get.put(RegisterController());

  RegisterPage({super.key});

  Widget _imageField(String label, Rxn<File> image, VoidCallback onTap) {
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: onTap,
              child: Container(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[200],
                ),
                child: image.value == null
                    ? Icon(Icons.add_a_photo, size: 40)
                    : Image.file(image.value!, fit: BoxFit.cover),
              ),
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('إنشاء حساب')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            MyTextField(controller: controller.firstName, labelText: 'الاسم'),
            SizedBox(height: 10),
            MyTextField(controller: controller.lastName, labelText: 'النسبة'),
            SizedBox(height: 10),
            MyTextField(
                controller: controller.fatherName, labelText: 'اسم الأب'),
            SizedBox(height: 10),
            MyTextField(
                controller: controller.motherName, labelText: 'اسم الأم'),
            SizedBox(height: 20),
            Obx(
              () => ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                          controller.selectedPlace.value != ''
                              ? Colors.blue.shade100
                              : Colors.red.shade300)),
                  onPressed: () => getPlaceDialog(
                      context: context, registerController: controller),
                  child: Text(
                    "معلومات المكان",
                  )),
            ),
            MyTextField(controller: controller.address, labelText: 'العنوان'),
            Obx(() => TextField(
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'تاريخ الميلاد',
                  ),
                  controller:
                      TextEditingController(text: controller.birthDate.value),
                  onTap: () async {
                    final date = await datePick(context);
                    if (date != null) {
                      controller.birthDate.value =
                          date.toLocal().toString().split(' ')[0];
                    }
                  },
                )),
            SizedBox(height: 20),
            MyTextField(
                controller: controller.birthPlace, labelText: 'مكان الولادة'),
            SizedBox(height: 10),
            TextField(
                controller: controller.nationalId,
                decoration: InputDecoration(labelText: 'الرقم الوطني')),
            SizedBox(height: 10),
            TextField(
                controller: controller.identityNumber,
                decoration: InputDecoration(labelText: 'رقم الهوية')),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: addPhoneNumber(controller.phoneController),
            ),

            Obx(() => TextField(
                  controller: controller.email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'البريد الإلكتروني',
                    hintText: 'example@email.com',
                    errorText: controller.emailText.value.isNotEmpty &&
                            !GetUtils.isEmail(controller.emailText.value)
                        ? 'البريد الإلكتروني غير صالح'
                        : null,
                  ),
                  onChanged: (val) {
                    controller.emailText.value = val;
                    controller.email.text = val;
                    controller.email.selection = TextSelection.fromPosition(
                        TextPosition(offset: controller.email.text.length));
                  },
                )),
            SizedBox(height: 10),
            // MyTextField(
            //     controller: controller.email, labelText: 'البريد الإلكتروني'),
            SizedBox(height: 10),
            _imageField('صورة الهوية الأمامية', controller.idFrontImage,
                () => controller.pickImage(controller.idFrontImage)),
            SizedBox(height: 10),
            _imageField('صورة الهوية الخلفية', controller.idBackImage,
                () => controller.pickImage(controller.idBackImage)),
            SizedBox(height: 10),
            TextField(
              controller: controller.username,
              decoration: InputDecoration(label: Text('اسم المستخدم')),
            ),
            SizedBox(height: 10),
            Obx(() => TextField(
                  obscureText: controller.obscurePassword.value,
                  decoration: InputDecoration(
                    labelText: 'كلمة السر',
                    suffixIcon: IconButton(
                      icon: Icon(
                        color: AppColors.mainColor,
                        controller.obscurePassword.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        controller.obscurePassword.toggle();
                      },
                    ),
                  ),
                  onChanged: (val) => controller.password.value = val,
                )),
            SizedBox(height: 10),
            Obx(() => TextField(
                  obscureText: controller.obscureConfirmPassword.value,
                  decoration: InputDecoration(
                    labelText: 'تأكيد كلمة السر',
                    errorText: controller.confirmPassword.value.isNotEmpty &&
                            controller.password.value !=
                                controller.confirmPassword.value
                        ? 'كلمة السر غير متطابقة'
                        : null,
                    suffixIcon: IconButton(
                      icon: Icon(
                        color: AppColors.mainColor,
                        controller.obscureConfirmPassword.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        controller.obscureConfirmPassword.toggle();
                      },
                    ),
                  ),
                  onChanged: (val) => controller.confirmPassword.value = val,
                )),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                AwesomeD(
                    ctx: context,
                    okF: () async {
                      await controller.submitForm();
                    },
                    title: 'هل تريد إنشاء الحساب؟');
              },
              child: Text('إنشاء حساب'),
            )
          ],
        ),
      ),
    );
  }
}
