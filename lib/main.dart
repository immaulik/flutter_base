import 'package:flutter/material.dart';
import 'package:flutter_base/my_app.dart';
import 'package:get_storage/get_storage.dart';

import 'core/utils/utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Utils.darkStatusBar();
  Utils.screenPortrait();
  Utils.hideKeyboard();

  await GetStorage.init();

  runApp(const MyApp());
}
