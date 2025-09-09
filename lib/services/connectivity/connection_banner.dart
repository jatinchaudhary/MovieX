import 'dart:async';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectionBanner extends StatefulWidget {
  const ConnectionBanner({super.key});

  @override
  State<ConnectionBanner> createState() => _ConnectionBannerState();
}

class _ConnectionBannerState extends State<ConnectionBanner> {
  bool _isOnline = true;
  bool _showBanner = false;
  late StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = Connectivity().onConnectivityChanged.listen((result) async {
      bool online = result[0] == ConnectivityResult.mobile || result[0] == ConnectivityResult.wifi;

      if (!online) {
        setState(() {
          _isOnline = false;
          _showBanner = true;
        });
      } else {
        setState(() {
          _isOnline = true;
        });
        await Future.delayed(const Duration(seconds: 1));
        setState(() {
          _showBanner = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
      duration: const Duration(milliseconds: 400),
      offset: _showBanner ? Offset(0, 0) : Offset(0, 1),
      curve: Curves.easeInOut,
      child: SafeArea(
        minimum: const EdgeInsets.only(bottom: 16),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 5),
            decoration: BoxDecoration(
              color: _isOnline ? Colors.green : Colors.red,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(_isOnline ? Icons.wifi : Icons.wifi_off, color: Colors.white, size: 12,),
                const SizedBox(width: 8),
                Text(
                  _isOnline ? 'Connected' : 'No Internet Connection',
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 10),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
