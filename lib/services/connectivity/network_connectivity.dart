import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

class InternetConnectivity {
  InternetConnectivity._privateConstructor();
  static final InternetConnectivity _instance = InternetConnectivity._privateConstructor();
  static InternetConnectivity get instance => _instance;

  final Connectivity _connectivity = Connectivity();

  /// Returns the current online status
  Future<bool> checkOnline() async {
    final List<ConnectivityResult> result = await _connectivity.checkConnectivity();
    return result[0] == ConnectivityResult.mobile || result[0] == ConnectivityResult.wifi;
  }

  void dispose() {
  }

}
