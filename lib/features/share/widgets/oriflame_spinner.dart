import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

/// The branded loader used in the share card: a soft-green disc with a spinning
/// brand-green ring — standing in for the Oriflame emblem.
class OriflameSpinner extends StatelessWidget {
  const OriflameSpinner({this.size = 56, super.key});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        color: AppColors.primarySoft,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: SizedBox(
        width: size * 0.5,
        height: size * 0.5,
        child: const CircularProgressIndicator(
          strokeWidth: 3,
          color: AppColors.primary,
        ),
      ),
    );
  }
}
