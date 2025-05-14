import 'package:flutter/material.dart';
import 'package:flutter_base/view/auth/login/login_controller.dart';
import 'package:flutter_base/widgets/app_app_bar.dart';
import 'package:get/get.dart';

class Login extends GetView<LoginController> {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(title: "Login",),
    );
  }
}
