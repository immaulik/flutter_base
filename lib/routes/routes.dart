import 'package:flutter_base/view/auth/login/login_controller.dart';
import 'package:flutter_base/view/auth/splash/splash_controller.dart';
import 'package:flutter_base/view/auth/splash/splash_view.dart';
import 'package:get/get.dart';
import '../view/auth/login/login.dart';
import 'routes_name.dart';

/// Function to define a GetPage route
GetPage getPage({
  String? name,
  GetPageBuilder? page,
  Bindings? binding,
  List<GetPage<dynamic>>? children,
}) {
  return GetPage(
    name: name!,
    page: page!,
    binding: binding,
    children: children ?? [],
  );
}

/// List of all routes
List<GetPage> pages = [
  getPage(
    name: RoutesName.login,
    page: () => const Login(),
    binding: BindingsBuilder(
      () => Get.lazyPut(
        () => LoginController(),
      ),
    ),
  ),
  getPage(
    name: RoutesName.splash,
    page: () => SplashView(),
  ),
];
