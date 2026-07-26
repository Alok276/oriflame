import 'package:flutter/material.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../data/models/share_platform.dart';

/// The "Quick share to:" strip — the label and a horizontally scrollable list
/// of brand buttons on a single line.
///
/// Canvas note: "This list is scrollable."
class QuickShareRow extends StatelessWidget {
  const QuickShareRow({
    required this.platforms,
    required this.onShare,
    super.key,
  });

  final List<SharePlatform> platforms;
  final ValueChanged<SharePlatform> onShare;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          AppStrings.quickShareTo,
          style: AppTypography.label.copyWith(color: AppColors.textWhite),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: SizedBox(
            height: _ShareButton.size,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: platforms.length,
              separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.sm),
              itemBuilder: (BuildContext context, int index) => _ShareButton(
                platform: platforms[index],
                onTap: () => onShare(platforms[index]),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// A single share destination: the brand glyph inside a translucent circle,
/// tappable, with a brand-coloured icon fallback if the asset is missing.
class _ShareButton extends StatelessWidget {
  const _ShareButton({required this.platform, required this.onTap});

  final SharePlatform platform;
  final VoidCallback onTap;

  /// Diameter of the translucent circle.
  static const double size = 36;

  /// Inset of the glyph inside the circle.
  static const double _pad = 7;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'Share to ${platform.label}',
      child: Tooltip(
        message: platform.label,
        child: SizedBox(
          width: size,
          height: size,
          child: Material(
            color: AppColors.glass,
            shape: const CircleBorder(),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.all(_pad),
                child: platform.glyphPath != null
                    ? Image.asset(
                        platform.glyphPath!,
                        fit: BoxFit.contain,
                        errorBuilder: (_, _, _) => _fallbackIcon(),
                      )
                    : _fallbackIcon(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _fallbackIcon() =>
      Icon(platform.icon, size: size - _pad * 2, color: platform.color);
}
