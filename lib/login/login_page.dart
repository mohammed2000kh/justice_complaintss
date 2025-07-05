import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../core/constants/colors.dart';
import 'login_controller.service.dart';
import '../view/regester_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late VideoPlayerController _videoController;

  void startAnimation() {
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.8, end: 1).animate(_controller);
  }

  @override
  void initState() {
    startAnimation();
    _videoController = VideoPlayerController.asset('assets/images/video.mp4')
      ..initialize().then((_) {
        setState(() {});
        _videoController.play();
        // _videoController.setLooping(true);
      }).catchError((error) {
        print('Error initializing video: $error');
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final control = Get.put(LoginController());
    final TextEditingController userName = TextEditingController();
    final TextEditingController password = TextEditingController();

    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(children: [
                        const SizedBox(height: 100),
                        SvgPicture.asset(
                          'assets/images/1.svg',
                          color: AppColors.mainColor,
                        ),
                      ]),
                      SvgPicture.asset(
                        'assets/images/2.svg',
                        color: AppColors.mainColor,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 200,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        'تسجيل الدخول',
                        style: TextStyle(shadows: [
                          BoxShadow(
                            offset: const Offset(0, 5),
                            color: Colors.black.withOpacity(0.5),
                            blurRadius: 10,
                          )
                        ], fontWeight: FontWeight.bold, fontSize: 27),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              SizedBox(
                  width: 190,
                  height: 190,
                  child: AnimatedBuilder(
                      animation: _animation,
                      builder: (context, child) => Center(
                            child: Transform.scale(
                              scale: _animation.value,
                              child: _videoController.value.isInitialized
                                  ? AspectRatio(
                                      aspectRatio:
                                          _videoController.value.aspectRatio,
                                      child: VideoPlayer(
                                        _videoController,
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                            ),
                          ))),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: _buildTextField(
                    controller: userName,
                    isPassword: false,
                    hintText: 'اسم المستخدم',
                    icon: CupertinoIcons.person_fill,
                    onPressed: () {},
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Obx(
                  () => _buildTextField(
                      controller: password,
                      isPassword: control.isPassword.value,
                      hintText: 'كلمة المرور',
                      icon: control.isPassword.isTrue
                          ? CupertinoIcons.eye_slash_fill
                          : CupertinoIcons.eye_solid,
                      onPressed: () => control.changeIsPassword(),
                      textInputAction: TextInputAction.done),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, right: 15, left: 15),
                child: InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    control.login(userName.text, password.text, context);
                  },
                  child: Container(
                    height: 55,
                    width: 335,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      gradient: const LinearGradient(
                          colors: [AppColors.mainColor, AppColors.mainColor2],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter),
                    ),
                    child: Center(
                        child: Obx(() => control.waitLogin.value
                            ? const CircularProgressIndicator(
                                color: AppColors.mainColor,
                              )
                            : const Text('دخول',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)))),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  Get.to(() => RegisterPage());
                },
                child: Text('إنشاء حساب جديد',
                    style: TextStyle(
                      color: AppColors.mainColor,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.mainColor,
                      decorationThickness: 1,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ],
          ),
        ));
  }
}

Widget _buildTextField({
  required TextEditingController controller,
  required String hintText,
  required bool isPassword,
  required IconData icon,
  required Function onPressed,
  TextInputType? keyboardType,
  required TextInputAction textInputAction,
  FocusNode? focusNode,
}) {
  return SizedBox(
    height: 55,
    width: 335,
    child: Stack(
      children: [
        // TextField
        TextField(
          textInputAction: textInputAction,
          keyboardType: keyboardType,
          controller: controller,
          focusNode: focusNode,
          // onSubmitted: (_) {
          //   if (nextFocusNode != null) {
          //     FocusScope.of(focusNode?.context ?? ctx)
          //         .requestFocus(nextFocusNode);
          //   }
          // },
          obscureText: isPassword,
          textAlign: TextAlign.right,
          decoration: InputDecoration(
            fillColor: AppColors.trans,
            hintText: hintText,
            filled: true,
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(25)),
            ),
          ),
          style: const TextStyle(color: Colors.black),
        ),
        Positioned(
          left: 10,
          top: 0,
          bottom: 0,
          child: GestureDetector(
            onTap: () => onPressed(),
            child: Icon(
              icon,
              color: AppColors.mainColor,
            ),
          ),
        ),
      ],
    ),
  );
}
