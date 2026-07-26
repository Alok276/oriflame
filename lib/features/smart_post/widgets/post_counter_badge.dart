import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';

/// The "1 of 3" pill in the top-right of a post card.
class PostCounterBadge extends StatelessWidget {
  const PostCounterBadge({
    required this.index,
    required this.total,
    super.key,
  });

  /// One-based position.
  final int index;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.glassStrong,
        borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
      ),
      child: Text(
        '$index of $total',
        style: AppTypography.label.copyWith(color: AppColors.textWhite),
      ),
    );
  }
}
