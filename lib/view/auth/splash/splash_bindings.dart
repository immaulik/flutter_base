import 'package:flutter_base/view/auth/splash/splash_controller.dart';
import 'package:get/get.dart';

class SplashBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<SplashController>(SplashController());
  }
}
