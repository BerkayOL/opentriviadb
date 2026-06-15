import 'package:flutter/material.dart';

class ThemeModeTile extends StatelessWidget {
  const ThemeModeTile({
    required this.title,
    required this.selected,
    required this.icon,
    required this.subtitle,
    required this.onTap,
    super.key,
  });
  final Icon icon;
  final String subtitle;
  final String title;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(title),
      trailing: selected ? const Icon(Icons.check_circle) : null,
    );
  }
}
