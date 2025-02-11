import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import '../logging/logger.dart';

class ADDeviceUtils {
  ADDeviceUtils._();

  static bool isIOS() => Platform.isIOS;
  static bool isAndroid() => Platform.isAndroid;
  static double getAppBarHeight() => kToolbarHeight;
  static double getBottomNavigationBarHeight() => kBottomNavigationBarHeight;
  static double getScreenWidth(BuildContext context) => MediaQuery.of(context).size.width;
  static double getScreenHeight(BuildContext context) => MediaQuery.of(context).size.height;
  static double getPixelRatio(BuildContext context) => MediaQuery.of(context).devicePixelRatio;
  static double getStatusBarHeight(BuildContext context) => MediaQuery.of(context).padding.top;
  static double getKeyboardHeight(BuildContext context) => MediaQuery.of(context).viewInsets.bottom;
  static void hideKeyboard(BuildContext context) => FocusScope.of(context).requestFocus(FocusNode());
  static void vibrate(Duration duration) => Future.delayed(duration, () => HapticFeedback.vibrate());
  static bool isPortraitOrientation(BuildContext context) => View.of(context).viewInsets.bottom != 0;
  static bool isLandscapeOrientation(BuildContext context) => View.of(context).viewInsets.bottom == 0;
  static void hideStatusBar() => SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  static Future<bool> isKeyboadVisible(BuildContext context) async => MediaQuery.of(context).viewInsets.bottom > 0;
  static void showStatusBar() => SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
  static Future<void> setStatusBarColor(Color color) async => SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: color));
  static void setFullScreen(bool enable) => SystemChrome.setEnabledSystemUIMode(enable ? SystemUiMode.immersiveSticky : SystemUiMode.edgeToEdge);
  static Future<bool> isPhysicalDevice() async => defaultTargetPlatform == TargetPlatform.android || defaultTargetPlatform == TargetPlatform.iOS;
  static Future<void> setPreferredOrientations(List<DeviceOrientation> orientations) async => await SystemChrome.setPreferredOrientations(orientations);

  static Future<bool> hasInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('fast.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (e) {
      LoggerHelper.error('Internet connection check failed: $e');
      return false;
    }
  }
}
