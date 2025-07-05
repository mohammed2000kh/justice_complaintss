import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_text_field/phone_text_field.dart';

import '../core/constants/colors.dart';

Future<DateTime?> datePick(BuildContext context) {
  return showDatePicker(
    context: context,
    initialDate: DateTime(1990),
    firstDate: DateTime(1900),
    lastDate: DateTime(2015),
    cancelText: 'إلغاء',
    confirmText: 'موافق',
    helpText: 'اختر التاريخ',
    locale: const Locale('ar', ''),
  );
}


Obx addPhoneNumber(TextEditingController controller) {
  RxString controller2 = controller.text.obs;

  return Obx(() => PhoneTextField(
        initialValue: controller.text,
        disableLengthCheck: true,
        showCountryCodeAsIcon: false,
        locale: const Locale('ar'),
        decoration: InputDecoration(
          errorText: controller2.value.trim().isNotEmpty && controller2.value.trim().length - 8 < 2
              ? 'الرقم قصير'
              : null,
          fillColor: Colors.transparent,
          filled: true,
          contentPadding: EdgeInsets.zero,
          prefixIcon: Icon(Icons.phone),
          labelText: "رقم الهاتف",
        ),
        searchFieldInputDecoration: InputDecoration(
          fillColor: AppColors.trans,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(),
          ),
          suffixIcon: Icon(Icons.search),
          hintText: "ابحث عن الدولة بالاسم أو الرمز",
        ),
        dialogTitle: "اختر الدولة",
        initialCountryCode: "SY",
        onChanged: (phone) {
          controller.text = phone.completeNumber;
          controller2.value = phone.completeNumber;
        },
      ));
}

Column dropDowns({
  required String label,
  required RxInt id,
  required RxList list,
  IconData? icon,
  Function({required int newValue, int itemIdValue, String value})? onChanged,
}) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.all(0.0),
        child: Row(
          children: [
            if (icon != null)
              IconButton.filledTonal(onPressed: () {}, icon: Icon(icon)),
            Text(
              '$label :',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      DropdownButton<int>(
        isExpanded: true,
        value: id.value >= 0 && id.value < list.length ? id.value : null,
        onChanged: (int? newValue) {
          if (newValue != null) {
            id.value = newValue;
            if (onChanged != null) {
              onChanged(
                  newValue: newValue,
                  itemIdValue: list[newValue].id,
                  value: list[newValue].name,);
            }
          }
        },
        selectedItemBuilder: (BuildContext context) {
          return list.map<Widget>((item) {
            return FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                label == 'الطابق' ? item.floorTypeV : item.name,
                style: const TextStyle(fontSize: 16),
              ),
            );
          }).toList();
        },
        items: List.generate(list.length, (index) {
          final isSelected = index == id.value; // التحقق إذا كان العنصر مختاراً
          return DropdownMenuItem(
            value: index,
            child: Container(
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.blue
                        .withOpacity(0.2) // لون الخلفية للعناصر المختارة
                    : Colors.transparent, // العناصر غير المختارة بدون خلفية
                borderRadius: BorderRadius.circular(8), // حواف مستديرة
              ),
              // padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Text(
                        label == 'الطابق'
                            ? list[index].floorTypeV
                            : list[index].name,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                          color: isSelected ? Colors.blue : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    ],
  );
}
