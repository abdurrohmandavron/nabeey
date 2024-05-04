import 'package:flutter/foundation.dart';
import 'package:nabeey/utils/logging/logger.dart';
import 'package:nabeey/utils/loaders/loaders.dart';

class ADException {
  late String message;
  String code = '';
  ADException(exception) {
    message = "Xatolik yuz berdi.";

    if (kDebugMode) LoggerHelper.error(message + code);
    ADLoaders.errorSnackBar(title: "Xato", message: message);
  }
}
