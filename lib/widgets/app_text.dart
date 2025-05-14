import 'package:flutter/material.dart';
import 'package:flutter_base/core/constants/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

enum TextSize { caption_12, body_14, body_16, subtitle_18, subTitle_20, title_24, title_32 }

class AppText extends StatelessWidget {
  final String text;
  final TextSize? textSize;
  final FontWeight? fontWeight;
  final Color? textColor;
  final bool? multiLine;
  final TextAlign? textAlign;
  final TextDecoration? textDecoration;
  final String fontFamily;

  const AppText(
    this.text, {
    super.key,
    this.textSize = TextSize.body_14,
    this.fontWeight = FontWeight.w400,
    this.textColor = AppColors.darkFontColor,
    this.multiLine = false,
    this.textAlign = TextAlign.left,
    this.textDecoration,
    this.fontFamily = "Poppins",
  });

  const AppText.multiLine(
    this.text, {
    super.key,
    this.textSize = TextSize.body_14,
    this.fontWeight = FontWeight.w400,
    this.textColor = AppColors.darkFontColor,
    this.textAlign = TextAlign.left,
    this.textDecoration,
    this.fontFamily = "Poppins",
  }) : multiLine = true;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: multiLine! ? null : 1,
      textAlign: textAlign,
      overflow: multiLine! ? TextOverflow.visible : TextOverflow.ellipsis,
      style: textStyle!.copyWith(
        color: textColor,
        fontFamily: fontFamily,
        fontWeight: fontWeight,
        decoration: textDecoration ?? TextDecoration.none,
      ),
    );
  }

  TextStyle? get textStyle {
    switch (textSize) {
      case TextSize.caption_12:
        return Theme.of(Get.context!).textTheme.bodySmall!.copyWith(fontSize: 12.sp);
      case TextSize.body_14:
        return Theme.of(Get.context!).textTheme.bodyMedium!.copyWith(fontSize: 14.sp);
      case TextSize.body_16:
        return Theme.of(Get.context!).textTheme.bodyLarge!.copyWith(fontSize: 16.sp);
      case TextSize.subtitle_18:
        return Theme.of(Get.context!).textTheme.titleLarge!.copyWith(fontSize: 18.sp);
      case TextSize.subTitle_20:
        return Theme.of(Get.context!).textTheme.titleLarge!.copyWith(fontSize: 20.sp);
      case TextSize.title_24:
        return Theme.of(Get.context!).textTheme.headlineSmall!.copyWith(fontSize: 24.sp);
      case TextSize.title_32:
        return Theme.of(Get.context!).textTheme.headlineLarge!.copyWith(fontSize: 32.sp);
      default:
        return Theme.of(Get.context!).textTheme.bodyMedium!.copyWith(fontSize: 14.sp);
    }
  }
}
