import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base/core/constants/app_colors.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
class Utils {

  static void darkStatusBar() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
  }

  /// Set the status bar style to light
  static void lightStatusBar() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarDividerColor: Colors.white,
      ),
    );
  }

  /// Set the preferred screen orientation to portrait
  static void screenPortrait() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  /// Get the type of the device (Android or iOS)
  static String getDeviceType() {
    return Platform.isAndroid ? 'Android' : 'iOS';
  }

  /// Show a toast message
  static void showToast({required String message}) {
    Fluttertoast.showToast(
      msg: message,
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_SHORT,
      textColor: Colors.white,
      backgroundColor: AppColors.primaryColor,
    );
  }

  /// Show a snack bar
  static void showSnackBar({
    String title = "",
    Color? backgroundColor,
    Color? titleColor,
    required String message,
  }) {
    Get.snackbar(
      title,
      message,
      borderRadius: 10,
      snackPosition: SnackPosition.BOTTOM,
      colorText: titleColor ?? Colors.white,
      backgroundColor: backgroundColor ?? Colors.redAccent,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14)
          .copyWith(top: 8),
      margin: const EdgeInsets.all(10),
      titleText: title.isEmpty ? const SizedBox.shrink() : null,
    );
  }



  static void hideKeyboard() => Get.focusScope?.unfocus();

  /// Launches a URL
  static void launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  /// Initialize platform state to get device information
  static Future<Map<String, String>> initPlatformState(String fcmToken) async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    RxString deviceId = "".obs;
    RxString deviceType = "".obs;
    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidDeviceInfo =
            (await deviceInfoPlugin.androidInfo);
        deviceId.value = androidDeviceInfo.id;
        deviceType.value = "Android";
      } else if (Platform.isIOS) {
        IosDeviceInfo iosDeviceInfo = (await deviceInfoPlugin.iosInfo);
        deviceId.value = iosDeviceInfo.identifierForVendor ?? "";
        deviceType.value = "iOS";
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return {
      "device_id": deviceId.value,
      "device_type": deviceType.value,
    };
  }

  /// Convert duration to minutes
  static String convertDurationToMinutes(String text) {
    String data = '00:00:30';
    List<String> splitData = data.toString().split(':');
    int result = (int.parse(splitData[0].toString()) * 60) +
        int.parse(splitData[1].toString());
    int duration = result;
    if (splitData[2].toString() != '0') {
      duration = result + 1;
    }
    return "$duration Min";
  }

  /// Change date format
  static String changeDateFormat({DateTime? date, String? outputFormat}) {
    if (date != null && outputFormat != null) {
      DateFormat formatter = DateFormat(outputFormat);
      String formatted = formatter.format(date);
      return formatted;
    }
    return 'N/A';
  }

  /// Convert UTC date to local date
  static String utcToLocal(String utcDateTime) {
    DateTime dateTime = DateTime.parse(utcDateTime).toLocal();
    return DateFormat("dd/MM/yyyy").format(dateTime);
  }

  /// Get time ago since a date
  static String timeAgoSinceDate(
    String dateString, {
    bool numericDates = true,
  }) {
    DateTime dateUtc = DateTime.parse(dateString);
    var dateTime =
        DateFormat("yyyy-MM-dd HH:mm:ss").parse(dateUtc.toString(), true);
    DateTime date = dateTime.toLocal();
    final date2 = DateTime.now();
    final difference = date2.difference(date);

    if ((difference.inDays / 365).floor() >= 2) {
      return (numericDates)
          ? '${(difference.inDays / 365).floor()} Y'
          : '${(difference.inDays / 365).floor()} Years ago';
    } else if ((difference.inDays / 365).floor() >= 1) {
      return (numericDates) ? '1 Y' : 'Last year';
    } else if ((difference.inDays / 30).floor() >= 2) {
      return '${(difference.inDays / 365).floor()} M';
    } else if ((difference.inDays / 30).floor() >= 1) {
      return (numericDates) ? '1 M' : 'Last Month';
    } else if ((difference.inDays / 7).floor() >= 2) {
      return (numericDates)
          ? '${(difference.inDays / 7).floor()} w'
          : '${(difference.inDays / 7).floor()} Weeks ago';
    } else if ((difference.inDays / 7).floor() >= 1) {
      return (numericDates) ? '1 w' : 'Last week';
    } else if (difference.inDays >= 2) {
      return (numericDates)
          ? '${difference.inDays} d'
          : '${difference.inDays} Days ago';
    } else if (difference.inDays >= 1) {
      return (numericDates) ? '1 d' : 'Yesterday';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours} h';
    } else if (difference.inHours >= 1) {
      return (numericDates) ? '1 h' : 'An hour ago';
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes} min';
    } else if (difference.inMinutes >= 1) {
      return (numericDates) ? '1 min' : 'A minute ago';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} sec';
    } else {
      return 'now';
    }
  }

  // static Future<XFile?> pickImage(ImageSource source) async {
  //   try {
  //     XFile? xFile = await _picker.pickImage(source: source);
  //     if (xFile != null) {
  //       return xFile;
  //     }
  //     return null;
  //   } catch (e) {
  //     return null;
  //   }
  // }
  //
  // static Future<List<String>> pickMultipleImage() async {
  //   try {
  //     List<XFile> xFile = await _picker.pickMultiImage();
  //     if (xFile.isNotEmpty) {
  //       List<String> images = xFile.map((e) {
  //         String base64String = base64Encode(File(e.path).readAsBytesSync());
  //         return 'data:image/png;base64,$base64String';
  //       }).toList();
  //       return images;
  //     }
  //     return [];
  //   } catch (e) {
  //     return [];
  //   }
  // }
  //
  // static Future<Result<PlatformFile, String>> pickFile() async {
  //   try {
  //     FilePickerResult? result = await FilePicker.platform.pickFiles(
  //       type: FileType.custom,
  //       allowedExtensions: ['pdf'],
  //       allowMultiple: false,
  //     );
  //
  //     if (result != null) {
  //       return Success(result.files.first);
  //     }
  //     return Failure(ErrorMessage.selectFile);
  //   } catch (e) {
  //     return Failure(ErrorMessage.selectFile);
  //   }
  // }

  static Future<String> getDownloadFolderPath() async {
    Directory? downloadDir;
    if (Platform.isAndroid) {
      downloadDir = await getDownloadsDirectory();
    } else if (Platform.isIOS) {
      downloadDir = await getApplicationDocumentsDirectory();
    }

    if (downloadDir == null) {
      throw Exception('Failed to get download folder path.');
    }

    return downloadDir.path;
  }

  static Future<String?> imageToBase64(ui.Image image) async {
    // Convert the image to PNG format
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    if (byteData == null) return null;

    // Convert the byte data to a list of integers
    Uint8List pngBytes = byteData.buffer.asUint8List();

    // Encode the image bytes to base64
    String base64Image = base64Encode(pngBytes);

    return base64Image;
  }
}
