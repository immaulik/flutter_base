import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base/core/constants/app_colors.dart';
import 'package:flutter_base/core/constants/font_const.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// To management App light and dark theme and typography --------- >>>
class AppTheme {
  static ThemeData lightTheme = ThemeData.light().copyWith(
    /// Colors
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.white,
    // disabledColor: AppColors.disableColor,
    // hoverColor: const Color(0x80C5C2C2),
    // splashColor: const Color(0x66C8C8C8),

    /// Gesture
    splashFactory: InkRipple.splashFactory,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    highlightColor: Colors.transparent,
    indicatorColor: AppColors.primaryColor,

    /// Appbar theme
    appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: AppColors.homeContainerBackground,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(
          color: AppColors.black,
        ),
        centerTitle: true,
        titleTextStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14.sp,
            color: AppColors.black,
            fontFamily: FontConst.poppins)),

    /// Text theme
    textTheme: buildTextTheme(ThemeData.light().textTheme),
    primaryTextTheme: buildTextTheme(ThemeData.light().textTheme),

    /// Bottom Sheet theme
    bottomSheetTheme:
        const BottomSheetThemeData(surfaceTintColor: Colors.transparent),

    /// Button theme
    buttonTheme: ButtonThemeData(
      buttonColor: AppColors.actionColor,
      disabledColor: AppColors.disabledActionColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(double.maxFinite)),
    ),

    /// Note: uncomment if you using copyWith theme or it will throw error.
    primaryColor: AppColors.primaryColor,
    colorScheme: const ColorScheme.light().copyWith(
      brightness: Brightness.light,
      primary: AppColors.primaryColor,
      surface: AppColors.backgroundColor,
    ),
  );

  static ThemeData darkTheme = ThemeData.dark().copyWith(
    /// Colors
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.backgroundColor,
    // disabledColor: AppColors.disableColor,
    // hoverColor: const Color(0xC7C9C0C0),
    // splashColor: const Color(0xBEF3EFEF),

    /// Gesture
    splashFactory: InkRipple.splashFactory,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    highlightColor: Colors.transparent,
    indicatorColor: AppColors.primaryColor,

    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.light,
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      iconTheme: IconThemeData(
        color: AppColors.primaryColor,
      ),
    ),

    /// Text
    textTheme: buildTextTheme(ThemeData.dark().textTheme),
    primaryTextTheme: buildTextTheme(ThemeData.dark().textTheme),

    /// Bottom Sheet theme
    bottomSheetTheme:
        const BottomSheetThemeData(surfaceTintColor: Colors.transparent),

    /// Button theme
    buttonTheme: ButtonThemeData(
      buttonColor: AppColors.actionColor,
      disabledColor: AppColors.disabledActionColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(double.maxFinite)),
    ),

    /// Note: uncomment if you using copyWith theme or it will throw error.
    primaryColor: AppColors.primaryColor,
    colorScheme: const ColorScheme.dark().copyWith(
      brightness: Brightness.dark,
      primary: AppColors.primaryColor,
      surface: AppColors.backgroundColor,
    ),
  );
}

TextTheme buildTextTheme(TextTheme base) {
  return base.copyWith(
    //* Label
    labelSmall: TextStyle(
        fontSize: 11.0, fontFamily: FontConst.poppins, color: base.labelSmall!.color),
    labelMedium: TextStyle(
        fontSize: 12.0, fontFamily: FontConst.poppins, color: base.labelMedium!.color),
    labelLarge: TextStyle(
        fontSize: 14.0, fontFamily: FontConst.poppins, color: base.labelLarge!.color),

    //* Body Text
    bodySmall: TextStyle(
        fontSize: 12.0, fontFamily: FontConst.poppins, color: base.bodySmall!.color),
    bodyMedium: TextStyle(
        fontSize: 14.0, fontFamily: FontConst.poppins, color: base.bodyMedium!.color),
    bodyLarge: TextStyle(
        fontSize: 16.0, fontFamily: FontConst.poppins, color: base.bodyLarge!.color),

    //* Title
    titleSmall: TextStyle(
        fontSize: 14.0, fontFamily: FontConst.poppins, color: base.titleSmall!.color),
    titleMedium: TextStyle(
        fontSize: 16.0, fontFamily: FontConst.poppins, color: base.titleMedium!.color),
    titleLarge: TextStyle(
        fontSize: 22.0, fontFamily: FontConst.poppins, color: base.titleLarge!.color),

    //* Headline
    headlineSmall: TextStyle(
        fontSize: 24.0,
        fontFamily: FontConst.poppins,
        color: base.headlineSmall!.color),
    headlineMedium: TextStyle(
        fontSize: 28.0,
        fontFamily: FontConst.poppins,
        color: base.headlineMedium!.color),
    headlineLarge: TextStyle(
        fontSize: 32.0,
        fontFamily: FontConst.poppins,
        color: base.headlineLarge!.color),

    //* Display
    displaySmall: TextStyle(
        fontSize: 36.0, fontFamily: FontConst.poppins, color: base.displaySmall!.color),
    displayMedium: TextStyle(
        fontSize: 45.0,
        fontFamily: FontConst.poppins,
        color: base.displayMedium!.color),
    displayLarge: TextStyle(
        fontSize: 57.0, fontFamily: FontConst.poppins, color: base.displayLarge!.color),
  );
}

/// ---- Flutter official material 3 typography font size --------------- >>>
/*
Body Small  Size: 12, Height: 1.33
Body Medium  Size: 14, Height: 1.43
Body Large  Size: 16, Height: 1.5

Label Small  Size: 11, Height: 1.45
Label Medium  Size: 12, Height: 1.33
Label Large  Size: 14, Height: 1.43

Title Small  Size: 14, Height: 1.43
Title Medium  Size: 16, Height: 1.5
Title Large  Size: 22, Height: 1.27

Headline Small  Size: 24, Height: 1.33
Headline Medium  Size: 28, Height: 1.29
Headline Large  Size: 32, Height: 1.25

Display Small  Size: 36, Height: 1.22
Display Medium  Size: 45, Height: 1.16
Display Large  Size: 57, Height: 1.12
*/
