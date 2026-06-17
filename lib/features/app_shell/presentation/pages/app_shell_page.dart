import 'package:flutter/material.dart';

import '../widgets/floating_nav_bar.dart';

class AppShellPage extends StatelessWidget {
  const AppShellPage({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: child),
          const Align(
            alignment: Alignment.bottomCenter,
            child: FloatingNavBar(),
          ),
        ],
      ),
    );
  }
}
