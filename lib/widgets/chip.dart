import 'package:flutter/material.dart';

class RepositoryDetailChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const RepositoryDetailChip({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Icon(icon, size: 20),
      label: Text('$label: $value'),
    );
  }
}
