import 'package:flutter/material.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/ai_badge.dart';

/// The top bar: the assistant control on the left, the brand logo centred, and
/// the camera control on the right — each with a small label beneath, per the
/// "Ready for dev" frame.
class SmartPostHeader extends StatelessWidget {
  const SmartPostHeader({
    required this.onAssistantTap,
    required this.onCameraTap,
    super.key,
  });

  final VoidCallback onAssistantTap;
  final VoidCallback onCameraTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.gutter,
        vertical: AppSpacing.xs,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          // Centred wordmark, falling back to text if the asset is missing.
          Center(
            child: Image.asset(
              AppAssets.logo,
              height: 26,
              errorBuilder: (_, _, _) =>
                  Text(AppStrings.appName, style: AppTypography.titleLarge),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: _HeaderAction(
              label: AppStrings.assistant,
              onTap: onAssistantTap,
              graphic: const _AssistantGlyph(),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: _HeaderAction(
              label: AppStrings.camera,
              onTap: onCameraTap,
              graphic: const _CameraGlyph(),
            ),
          ),
        ],
      ),
    );
  }
}

/// A header control: a graphic with a small label beneath it.
class _HeaderAction extends StatelessWidget {
  const _HeaderAction({
    required this.label,
    required this.onTap,
    required this.graphic,
  });

  final String label;
  final VoidCallback onTap;
  final Widget graphic;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: label,
      child: InkResponse(
        onTap: onTap,
        radius: 32,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            graphic,
            const SizedBox(height: 2),
            Text(
              label,
              style: AppTypography.label.copyWith(
                color: AppColors.textSecondary,
                fontSize: 9,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// The assistant glyph: the white Oriflame emblem on a charcoal circle, with a
/// green "AI" badge tucked into the top-right corner.
class _AssistantGlyph extends StatelessWidget {
  const _AssistantGlyph();

  static const double _circle = 34;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _circle + 6,
      height: _circle,
      child: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: _circle,
              height: _circle,
              decoration: const BoxDecoration(
                color: AppColors.darkCircle,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Image.asset(
                AppAssets.assistant,
                width: 22,
                height: 22,
                errorBuilder: (_, _, _) => const Icon(
                  Icons.blur_on,
                  color: AppColors.textWhite,
                  size: 20,
                ),
              ),
            ),
          ),
          const Positioned(top: -3, right: 0, child: AiBadge()),
        ],
      ),
    );
  }
}

/// The camera control glyph: a white camera on a charcoal circle.
class _CameraGlyph extends StatelessWidget {
  const _CameraGlyph();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 34,
      height: 34,
      decoration: const BoxDecoration(
        color: AppColors.darkCircle,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: const Icon(
        Icons.photo_camera,
        color: AppColors.textWhite,
        size: 18,
      ),
    );
  }
}
