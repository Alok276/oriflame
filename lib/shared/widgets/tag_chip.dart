import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';

/// A small pill chip that sits on the post photo.
///
/// Defaults to the pink "Ready to share" status style from the design: a soft
/// translucent fill with pink text and a leading sparkle.
class TagChip extends StatelessWidget {
  const TagChip({
    required this.label,
    this.icon = Icons.auto_awesome,
    this.background = _defaultBackground,
    this.foreground = AppColors.discount,
    this.gradient,
    super.key,
  });

  static const Color _defaultBackground = Color(0xF2FDE7F0); // soft pink glass

  final String label;
  final IconData? icon;
  final Color background;
  final Color foreground;

  /// Optional gradient fill; when set it wins over [background].
  final List<Color>? gradient;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: gradient == null ? background : null,
        gradient: gradient == null
            ? null
            : LinearGradient(colors: gradient!),
        borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (icon != null) ...<Widget>[
            Icon(icon, size: 11, color: foreground),
            const SizedBox(width: AppSpacing.xs),
          ],
          Text(
            label,
            style: AppTypography.label.copyWith(
              color: foreground,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
