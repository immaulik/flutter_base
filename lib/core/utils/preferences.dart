import 'package:get_storage/get_storage.dart';

/// Utility class for handling local storage operations.
class Preferences {
  static const String _onBoard = "onBoard";
  static const String _isVerified = "isVerified";
  static const String _isLogged = 'isLogged';
  static const String _token = 'token';
  static const String _email = 'email';
  static const String _isIntro = 'isIntro';

  /// Store is user login or logout
  static set isLogged(bool value) => GetStorage().write(_isLogged, value);

  static set isIntro(bool value) => GetStorage().write(_isIntro, value);

  static set onBoard(bool value) => GetStorage().write(_onBoard, value);

  static set isVerified(bool value) => GetStorage().write(_isVerified, value);

  /// Get is user is login or logout
  static bool get isLogged => GetStorage().read(_isLogged) ?? false;

  static bool get isIntro => GetStorage().read(_isIntro) ?? false;

  static bool get onBoard => GetStorage().read(_onBoard) ?? false;

  static bool get isVerified => GetStorage().read(_isVerified) ?? false;

  /// Store user login token
  static set token(String? value) => GetStorage().write(_token, value);

  static set email(String? value) => GetStorage().write(_email, value);

  /// Get user login token
  static String? get token => GetStorage().read(_token);

  static String? get email => GetStorage().read(_email);

  /// Store user data (Put user model)
  // static set user(User value) {
  //   final String encodedValue = jsonEncode(value.toJson());
  //   final GetStorage storage = GetStorage();
  //   storage.write(_user, encodedValue);
  // }

  /// Get user data (Put user model)
  // static User get user {
  //   final storage = GetStorage();
  //   final dynamic result = storage.read(_user);
  //   return User.fromJson(json.decode(result));
  // }

  /// Remove all user data and token
  static void logout() {
    final GetStorage storage = GetStorage();
    storage.write(_isLogged, false);
    storage.write(_token, null);
    storage.write(_isVerified, null);
    // Get.offAllNamed(RoutesName.signInView);
  }
}
