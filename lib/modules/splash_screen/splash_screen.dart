import 'package:equitysoft_practical/constants/colors_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        Get.offAndToNamed(AppRoutes.HOME_SCREEN);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColorConstants.whiteColor,
      body: Align(
        alignment: Alignment.center,
        child: Text(
          "Equity Soft Technology",
          style: TextStyle(
              color: AppColorConstants.greyColor,
              fontSize: 24.0,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
