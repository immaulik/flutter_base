import 'package:flutter/material.dart';
import 'package:flutter_base/core/constants/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

double get defaultPadding => 16.h;
double get defaultRadius => 20.r;
double get containerRadius => 8.r;

double get defaultTopPadding => ScreenUtil().statusBarHeight + defaultPadding;

double get defaultBottomPadding => ScreenUtil().bottomBarHeight == 0.0
    ? defaultPadding
    : (ScreenUtil().bottomBarHeight + 6.h);

BorderRadius get inkWellRadius => BorderRadius.circular(8.r);

Decoration get defaultDecoration => BoxDecoration(
    border: Border.all(
      color: AppColors.greyBorder,
      width: 1,
    ),
    borderRadius: BorderRadius.circular(8.r));
