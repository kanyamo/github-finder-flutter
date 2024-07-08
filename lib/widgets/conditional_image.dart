import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/test_mode_provider.dart';

class ConditionalCircleAvatar extends ConsumerWidget {
  final String networkUrl;
  final String assetPath;
  final double radius;

  const ConditionalCircleAvatar({
    super.key,
    required this.networkUrl,
    required this.assetPath,
    this.radius = 30,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isTestMode = ref.read(testModeProvider);

    return CircleAvatar(
      backgroundImage: isTestMode
          ? AssetImage(assetPath) as ImageProvider
          : NetworkImage(networkUrl),
    );
  }
}
