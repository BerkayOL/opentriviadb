import 'package:flutter/material.dart';

class SplashGlow extends StatelessWidget {
  const SplashGlow({
    super.key,
    required this.size,
    required this.fillColor,
    required this.shadowColor,
    required this.blurRadius,
    required this.spreadRadius,
  });

  final double size;
  final Color fillColor;
  final Color shadowColor;
  final double blurRadius;
  final double spreadRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: fillColor,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: blurRadius,
            spreadRadius: spreadRadius,
          ),
        ],
      ),
    );
  }
}
