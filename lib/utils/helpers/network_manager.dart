import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../logging/logger.dart';

class NetworkManager {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _subscription;
  final StreamController<ConnectivityResult> connectionStatusController = StreamController<ConnectivityResult>.broadcast();

  NetworkManager() {
    _listenChange();
  }

  void _listenChange() async {
    try {
      List<ConnectivityResult> result = await _connectivity.checkConnectivity();
      _handleConnectivityResult(result);

      _subscription = _connectivity.onConnectivityChanged.listen(
        _handleConnectivityResult,
        onError: (error) {
          LoggerHelper.error('Connectivity error: $error');
        },
      );
    } catch (e) {
      LoggerHelper.error('Failed to initialize connectivity: $e');
    }
  }

  void _handleConnectivityResult(List<ConnectivityResult> result) {
    if (!connectionStatusController.isClosed) {
      connectionStatusController.add(result[0]);
      _checkConnection(result[0]);
    }
  }

  Future<void> _checkConnection(ConnectivityResult result) async {
    if (result == ConnectivityResult.none) {
      // Show no internet warning
      LoggerHelper.warning("Internet aloqasi yo'q");
    }
  }

  Future<bool> isConnected() async {
    try {
      var connectivityResult = await _connectivity.checkConnectivity();
      return connectivityResult[0] != ConnectivityResult.none;
    } catch (e) {
      LoggerHelper.error('Connection check failed: $e');
      return false;
    }
  }

  Stream<ConnectivityResult> get connectionChange => connectionStatusController.stream;

  void dispose() {
    _subscription.cancel();
    connectionStatusController.close();
  }
}
