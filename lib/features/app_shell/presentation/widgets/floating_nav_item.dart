import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:opentriviadb/features/app_shell/presentation/cubits/nav_item_press_cubit.dart';

import 'floating_nav_item_body.dart';

class FloatingNavItem extends StatelessWidget {
  const FloatingNavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocProvider(
        create: (_) => NavItemPressCubit(),
        child: FloatingNavItemBody(
          icon: icon,
          isSelected: isSelected,
          label: label,
          onTap: onTap,
        ),
      ),
    );
  }
}
