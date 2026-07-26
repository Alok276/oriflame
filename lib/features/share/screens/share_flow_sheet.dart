import 'dart:async';

import 'package:flutter/material.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../data/models/share_platform.dart';
import '../../../shared/widgets/frosted_overlay.dart';
import '../widgets/oriflame_spinner.dart';

/// The share flow shown after a quick-share platform is tapped.
///
/// Matches the prototype: a blurred scrim behind a white card that steps through
/// "Generating your sales link…" and friends with a progress bar and the
/// Oriflame spinner, then briefly shows an `Opening <brand>…` splash before
/// dismissing.
class ShareFlow {
  const ShareFlow._();

  static Future<void> start(BuildContext context, SharePlatform platform) {
    return showGeneralDialog<void>(
      context: context,
      barrierDismissible: false,
      barrierLabel: 'Sharing',
      barrierColor: Colors.transparent,
      transitionDuration: const Duration(milliseconds: 220),
      pageBuilder: (_, _, _) => _ShareFlowSheet(platform: platform),
      transitionBuilder: (_, Animation<double> anim, _, Widget child) =>
          FadeTransition(opacity: anim, child: child),
    );
  }
}

class _ShareFlowSheet extends StatefulWidget {
  const _ShareFlowSheet({required this.platform});

  final SharePlatform platform;

  static const Duration stepDuration = Duration(milliseconds: 850);
  static const Duration holdDuration = Duration(milliseconds: 500);
  static const Duration openingDuration = Duration(milliseconds: 1000);

  @override
  State<_ShareFlowSheet> createState() => _ShareFlowSheetState();
}

class _ShareFlowSheetState extends State<_ShareFlowSheet> {
  static const List<String> _steps = AppStrings.shareSteps;

  Timer? _timer;
  int _step = 0;
  bool _opening = false;

  @override
  void initState() {
    super.initState();
    _advance();
  }

  void _advance() {
    _timer = Timer(_ShareFlowSheet.stepDuration, () {
      if (!mounted) return;
      if (_step < _steps.length - 1) {
        setState(() => _step++);
        _advance();
      } else {
        _timer = Timer(_ShareFlowSheet.holdDuration, _openPlatform);
      }
    });
  }

  void _openPlatform() {
    if (!mounted) return;
    setState(() => _opening = true);
    _timer = Timer(_ShareFlowSheet.openingDuration, () {
      if (mounted) Navigator.of(context).pop();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FrostedOverlay(
      blur: 8,
      color: AppColors.scrim,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 300),
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.xl,
            ),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
            ),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _opening ? _openingContent() : _loadingContent(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _loadingContent() {
    final double progress = (_step + 1) / _steps.length;
    return Column(
      key: const ValueKey<String>('loading'),
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const OriflameSpinner(),
        const SizedBox(height: AppSpacing.lg),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: Text(
            '${_steps[_step]}…',
            key: ValueKey<int>(_step),
            textAlign: TextAlign.center,
            style: AppTypography.body.copyWith(color: AppColors.textSecondary),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0, end: progress),
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOut,
          builder: (_, double value, _) => LinearProgressIndicator(
            value: value,
            minHeight: 6,
            backgroundColor: AppColors.primarySoft,
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
          ),
        ),
      ],
    );
  }

  Widget _openingContent() {
    return Column(
      key: const ValueKey<String>('opening'),
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _PlatformGlyph(platform: widget.platform),
        const SizedBox(height: AppSpacing.lg),
        Text(
          '${AppStrings.openingPrefix}${widget.platform.brand}…',
          textAlign: TextAlign.center,
          style: AppTypography.title,
        ),
      ],
    );
  }
}

/// The destination platform's glyph, shown on the "opening" splash.
class _PlatformGlyph extends StatelessWidget {
  const _PlatformGlyph({required this.platform});

  final SharePlatform platform;

  static const double size = 64;

  @override
  Widget build(BuildContext context) {
    final String? path = platform.glyphPath;
    if (path == null) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(color: platform.color, shape: BoxShape.circle),
        child: Icon(platform.icon, color: platform.foreground, size: size * 0.5),
      );
    }
    return ClipOval(
      child: Image.asset(
        path,
        width: size,
        height: size,
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) => Container(
          width: size,
          height: size,
          decoration:
              BoxDecoration(color: platform.color, shape: BoxShape.circle),
          child:
              Icon(platform.icon, color: platform.foreground, size: size * 0.5),
        ),
      ),
    );
  }
}
