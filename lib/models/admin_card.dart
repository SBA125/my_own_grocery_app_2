import 'package:flutter/material.dart';

class AdminCard {
  final String title;
  final IconData icon;
  final Function(BuildContext) onTap;

  AdminCard({
    required this.title,
    required this.icon,
    required this.onTap,
  });
}