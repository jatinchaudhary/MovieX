import 'package:flutter/material.dart';

class CustomNavIcon extends StatelessWidget {
  final IconData icon;
  final bool isActive;
  final double size;
  final Color? activeColor;
  final Color? inactiveColor;

  const CustomNavIcon({
    super.key,
    required this.icon,
    required this.isActive,
    this.size = 20,
    this.activeColor,
    this.inactiveColor,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Icon(
        icon,
        size: size,
        color: isActive
            ? (activeColor ?? Colors.white)
            : (inactiveColor ?? const Color.fromARGB(106, 255, 255, 255)),
      ),
    );
  }
}
