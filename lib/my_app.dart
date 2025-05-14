import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'core/constants/app_strings.dart';
import 'core/utils/stretch_scroll_behavior.dart';
import 'routes/routes.dart';
import 'routes/routes_name.dart';
import 'theme/app_theme.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  StreamSubscription<List<ConnectivityResult>>? subscription;

  @override
  void initState() {
    super.initState();
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
      // Optionally handle network changes
    });
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: AppStrings.appName,
          theme: AppTheme.lightTheme,
          themeMode: ThemeMode.light,
          getPages: pages,
          initialRoute: RoutesName.splash,
          scrollBehavior: ScrollBehaviorModified(),
          builder: (context, child) {
            final mediaQueryData = MediaQuery.of(context);
            final scale = mediaQueryData.textScaler
                .clamp(minScaleFactor: 1.0, maxScaleFactor: 1.14);
            return MediaQuery(
              data: mediaQueryData.copyWith(textScaler: scale),
              child: child!,
            );
          },
        );
      },
    );
  }
}
