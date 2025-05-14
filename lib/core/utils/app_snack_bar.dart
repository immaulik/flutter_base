import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/core/constants/app_colors.dart';
import 'package:flutter_base/widgets/app_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';


class AppSnackBar {
  static void success({required String message}) {
    Get.snackbar(
      "Success",
      message,
      messageText: AppText.multiLine(
        message,
        fontWeight: FontWeight.w500,
        textColor: Color(0xFF0B5400),
      ),
      borderRadius: 10,
      borderWidth: 1.4,
      shouldIconPulse: false,
      colorText: AppColors.black,
      snackStyle: SnackStyle.FLOATING,
      titleText: const SizedBox.shrink(),
      snackPosition: SnackPosition.BOTTOM,
      borderColor: const Color(0xFFC2F2BB),
      backgroundColor: const Color(0xFFC2F2BB),
      // icon:
      //     const Icon(CupertinoIcons.check_mark_circled, color: AppColors.black),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12)
          .copyWith(top: 6),
      margin: const EdgeInsets.symmetric(horizontal: 32).copyWith(bottom: 16),
    );
  }

  static void info(
      {required String message, void Function()? onPress, String? buttonText}) {
    Get.snackbar(
      "Info",
      message,
      messageText: AppText.multiLine(
        message,
        fontWeight: FontWeight.w500,
        textColor: AppColors.black,
      ),
      borderRadius: 10,
      borderWidth: 1.4,
      shouldIconPulse: false,
      colorText: AppColors.black,
      snackStyle: SnackStyle.FLOATING,
      titleText: const SizedBox.shrink(),
      snackPosition: SnackPosition.BOTTOM,
      borderColor: const Color(0xFF47AFFF),
      backgroundColor: const Color(0xFFEDF7FF),
      // icon: const Icon(CupertinoIcons.info, color: AppColors.black),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12)
          .copyWith(top: 6),
      margin: const EdgeInsets.symmetric(horizontal: 32).copyWith(bottom: 16),
      mainButton: onPress == null
          ? null
          : TextButton(
              onPressed: onPress,
              child: AppText(buttonText ?? "Open", fontWeight: FontWeight.w600),
            ),
    );
  }

  // static void warning(
  //     {required String message, void Function()? onPress, String? buttonText}) {
  //   Get.snackbar(
  //     "Warning",
  //     message,
  //     messageText: AppText.multiLine(
  //       message,
  //       fontWeight: FontWeight.w500,
  //       textColor: Color(0xFF542900),
  //     ),
  //     borderRadius: 10,
  //     borderWidth: 1.4,
  //     shouldIconPulse: false,
  //     colorText: AppColors.black,
  //     snackStyle: SnackStyle.FLOATING,
  //     titleText: const SizedBox.shrink(),
  //     snackPosition: SnackPosition.BOTTOM,
  //     borderColor: const Color(0xFFF2D6BB),
  //     backgroundColor: const Color(0xFFF2D6BB),
  //     icon: SvgPicture.asset(AppAssets.icWarning, height: 18.h),
  //     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12)
  //         .copyWith(top: 6),
  //     margin: const EdgeInsets.symmetric(horizontal: 32).copyWith(bottom: 16),
  //     mainButton: onPress == null
  //         ? null
  //         : TextButton(
  //             onPressed: onPress,
  //             child: AppText(buttonText ?? "Open", fontWeight: FontWeight.w600),
  //           ),
  //   );
  // }

  static void error(
      {required String message, void Function()? onPress, String? buttonText}) {
    Get.snackbar(
      "Error",
      message,
      messageText: AppText.multiLine(
        message,
        fontWeight: FontWeight.w500,
        textColor: Color(0xFF540000),
      ),
      borderRadius: 10,
      borderWidth: 1.4,
      shouldIconPulse: false,
      colorText: AppColors.black,
      snackStyle: SnackStyle.FLOATING,
      titleText: const SizedBox.shrink(),
      snackPosition: SnackPosition.BOTTOM,
      borderColor: const Color(0xFFF2BBBB),
      backgroundColor: const Color(0xFFF2BBBB),
      // icon: const Icon(CupertinoIcons.clear_circled, color: AppColors.black),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12)
          .copyWith(top: 6),
      margin: const EdgeInsets.symmetric(horizontal: 32).copyWith(bottom: 16),
      mainButton: onPress == null
          ? null
          : TextButton(
              onPressed: onPress,
              child: AppText(buttonText ?? "Open", fontWeight: FontWeight.w600),
            ),
    );
  }
}
