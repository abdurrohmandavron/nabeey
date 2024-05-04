import 'dart:async';
import 'package:get/get.dart';
import 'package:nabeey/utils/loaders/loaders.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkManager extends GetxController {
  static NetworkManager get instance => Get.find();

  final Connectivity _connectivity = Connectivity();

  // StreamController to broadcast connectivity changes
  StreamController<ConnectivityResult> connectionStatusController = StreamController<ConnectivityResult>();
  final RxList<ConnectivityResult> results = [ConnectivityResult.none].obs;
  NetworkManager() {
    // Initialize the controller and listen for changes

    _listenChange(results.first);
  }
  void _listenChange(ConnectivityResult result) {
    _connectivity.onConnectivityChanged.listen((result) async {
      if (result.first != results.first) {
        results.value = result;
        isConnected();
      }

      connectionStatusController.add(result.first);
      _listenChange(result.first);
    });
  }

  // Check current connectivity status
  Future<bool> isConnected() async {
    var connectivityResult = await _connectivity.checkConnectivity();
    _listenChange(results.first);
    if (connectivityResult.first != ConnectivityResult.none) {
      return true;
    } else {
      ADLoaders.warningSnackBar(title: "Internet aloqasi yo'q");
      return false;
    }
  }

  // Stream to listen for connectivity changes
  Stream<ConnectivityResult> get connectionChange => connectionStatusController.stream;
}
