/// Spacing, radii and fixed sizes, scaled off the 375×812 design frame.
///
/// No widget hard-codes a gap or a corner radius: if a `16` or an `8` appears
/// in a widget file, it belongs here.
class AppSpacing {
  const AppSpacing._();

  // ------------------------------------------------------------------ gaps
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;

  /// The standard card / screen inset used throughout the design.
  static const double gutter = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;

  // ---------------------------------------------------------------- radii
  static const double radiusSm = 8;
  static const double radiusMd = 12;
  static const double radiusLg = 20;
  static const double radiusPill = 999;
}

/// Fixed component sizes pulled from the design.
class AppSizes {
  const AppSizes._();

  /// The 375×812 frame the design was drawn on.
  static const double designWidth = 375;
  static const double designHeight = 812;

  static const double avatar = 40;
  static const double shareCircle = 32;
  static const double navIcon = 26;
  static const double productThumb = 56;
  static const double headerIcon = 24;

  /// Card corner-to-corner in the design; the feed card keeps this ratio.
  static const double cardHeight = 660;
}
