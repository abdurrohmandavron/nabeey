import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkManager {
  final Connectivity _connectivity = Connectivity();

  final StreamController<ConnectivityResult> connectionStatusController = StreamController<ConnectivityResult>.broadcast();

  NetworkManager() {
    _listenChange();
  }

  void _listenChange() async {
    List<ConnectivityResult> result = await _connectivity.checkConnectivity();
    connectionStatusController.add(result[0]); // Add the first element (ConnectivityResult)
    _connectivity.onConnectivityChanged.listen((newList) {
      if (newList[0] != result[0]) {
        result = newList;
        connectionStatusController.add(result[0]);
        isConnected(); // Call isConnected on change
      }
    });
  }

  // Check current connectivity status
  Future<bool> isConnected() async {
    var connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult[0] != ConnectivityResult.none) {
      return true;
    } else {
      // Show snackbar using a separate function (not included here)
      // e.g., showWarningSnackbar(title: "Internet aloqasi yo'q");
      return false;
    }
  }

  Stream<ConnectivityResult> get connectionChange => connectionStatusController.stream;

  void dispose() {
    connectionStatusController.close();
  }
}
