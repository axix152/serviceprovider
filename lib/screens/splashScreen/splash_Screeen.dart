import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:serviceprovider/global.dart';
import 'package:serviceprovider/screens/main_screen.dart';
import '../../const.dart';
import '../assistants/assistant_model.dart';
import '../authentication/logIn_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTimer() {
    fauth.currentUser != null ? AssistantModel.readCurrentUserInfo() : null;
    fauth.currentUser != null ? AssistantModel.currentUserDetails() : null;
    Timer(const Duration(seconds: 4), () async {
      if (await fauth.currentUser != null) {
        Get.offAll(MainScreen());
      } else {
        Get.toNamed('/logIn');
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 150.h,
              width: 150.w,
              child: Image.asset('assets/images/logo.png'),
            ),
            SizedBox(
              height: 2.h,
            ),
            const Text(
              "Service Provider",
              style: TextStyle(
                fontSize: 30.0,
                color: kprimarryColor,
              ),
            ),
          ],
        ),
      )),
    );
  }
}
