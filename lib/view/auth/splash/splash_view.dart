import 'package:flutter/material.dart';
import 'package:flutter_base/core/constants/app_assets.dart';
import 'package:flutter_base/core/constants/app_colors.dart';
import 'package:flutter_base/view/auth/splash/splash_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SplashView extends StatelessWidget {
   SplashView({super.key});

  final controller = Get.put(SplashController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: TweenAnimationBuilder(
        duration: const Duration(milliseconds: 1000),
        curve: Curves.linear,
        tween: Tween(begin: 20.0, end: 1.0),
        builder: (context, value, child) {
          return AnimatedOpacity(
            opacity: value == 20 ? 0 : 1,
            duration: const Duration(milliseconds: 800),
            child: AnimatedScale(
              scale: value == 20 ? 0 : 1,
              duration: const Duration(milliseconds: 800),
              child: Center(
                child: Text(
                  "Flutter Base",
                  style: TextStyle(
                    fontSize: 52.sp,
                    fontWeight: FontWeight.w800,
                    color: AppColors.darkFontColor,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
