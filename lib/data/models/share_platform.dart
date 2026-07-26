import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

/// A destination in the "Quick share to:" strip.
///
/// The design shows eleven circles, with Instagram, Facebook and WhatsApp
/// repeated. Those repeats are read as feed / story / reel / status variants,
/// encoded in [variant]: it drives the tooltip and the story ring.
enum ShareVariant {
  feed,
  story,
  reel,
  status;

  /// Story-style variants get a gradient ring around the circle.
  bool get hasRing => this == ShareVariant.story;

  String get label {
    switch (this) {
      case ShareVariant.feed:
        return 'Feed';
      case ShareVariant.story:
        return 'Story';
      case ShareVariant.reel:
        return 'Reel';
      case ShareVariant.status:
        return 'Status';
    }
  }
}

/// Brand glyphs are not bundled, so each circle uses its brand colour with a
/// representative Material [icon].
class SharePlatform {
  const SharePlatform({
    required this.id,
    required this.brand,
    required this.color,
    required this.icon,
    this.glyphPath,
    this.variant = ShareVariant.feed,
  });

  final String id;

  /// The brand name, e.g. "Instagram".
  final String brand;
  final Color color;
  final IconData icon;

  /// Optional path to a real brand glyph. When present it is drawn on the
  /// circle; when the asset is missing the coloured [icon] is used instead.
  final String? glyphPath;

  final ShareVariant variant;

  /// Label used in tooltips and toasts. Plain (feed) buttons read as just the
  /// brand; variant buttons disambiguate, e.g. "Instagram Story".
  String get label =>
      variant == ShareVariant.feed ? brand : '$brand ${variant.label}';

  /// Foreground colour that reads on top of [color].
  Color get foreground =>
      ThemeData.estimateBrightnessForColor(color) == Brightness.dark
          ? AppColors.textWhite
          : AppColors.textPrimary;

  bool get hasRing => variant.hasRing;
}
