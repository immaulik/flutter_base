import 'package:flutter_base/routes/routes_name.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  Future<void> nextPage() async {
    Future.delayed(const Duration(milliseconds: 1500), () {
      Get.offAllNamed(RoutesName.login);
    });
  }

  @override
  void onInit() {
    nextPage();
    super.onInit();
  }
}
