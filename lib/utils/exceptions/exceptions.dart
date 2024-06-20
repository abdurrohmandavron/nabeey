import 'package:flutter/foundation.dart';
import 'package:nabeey/utils/logging/logger.dart';

class ADException {
  late String message;
  String code = '';
  ADException(exception) {
    message = "Xatolik yuz berdi.";

    if (kDebugMode) LoggerHelper.error(exception.toString() + code + message);
  }
}
