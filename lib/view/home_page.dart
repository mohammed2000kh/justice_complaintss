import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:justice_complaints/core/service/cache_helper.dart';
import 'package:justice_complaints/main.dart';
import 'package:justice_complaints/widgets/methods.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _signOut(BuildContext context) {
    Get.offAllNamed('/LoginPage');
    login = false;
    token = '';
    CacheHelper.saveData(key: 'login', value: false);
    CacheHelper.saveData(key: 'token', value: '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الصفحة الرئيسية'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'تسجيل الخروج',
            onPressed: () => AwesomeD(
                ctx: context,
                okF: () => _signOut(context),
                title: 'تأكيد تسجيل الخروج'),
          ),
        ],
      ),
      body: const Center(
        child: Text(
          'مرحباً بك في الصفحة الرئيسية!',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
