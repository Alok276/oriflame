import 'dart:ui';

import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

/// A full-bleed blurred scrim. Sits behind modal content — used by the
/// generation overlay.
class FrostedOverlay extends StatelessWidget {
  const FrostedOverlay({
    required this.child,
    this.blur = 18,
    this.color = AppColors.scrim,
    super.key,
  });

  final Widget child;
  final double blur;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
      child: Container(
        color: color,
        child: child,
      ),
    );
  }
}
