import 'package:flutter/material.dart';

import '../theme/app_spacing.dart';

/// Scaling helpers keyed off the 375×812 design frame.
///
/// The design was drawn at one fixed size; these helpers let a widget express
/// a design measurement and have it scale sensibly on other handsets without
/// ballooning on tablets.
class Responsive {
  const Responsive._();

  /// Layouts wider than this keep a centred phone-width column.
  static const double wideBreakpoint = 600;

  /// Clamp bounds on the scale factor so the layout holds on small handsets
  /// and does not balloon on large ones.
  static const double _minScale = 0.85;
  static const double _maxScale = 1.30;

  /// Cap on user text scaling — the feed card is dense and unbounded scaling
  /// overflows it.
  static const double _maxTextScale = 1.30;

  static bool isWide(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= wideBreakpoint;

  /// A 0.85–1.30 factor derived from how the viewport width compares to the
  /// design width.
  static double scaleFactor(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    final double effective = isWide(context) ? 480 : width;
    return (effective / AppSizes.designWidth).clamp(_minScale, _maxScale);
  }

  /// Scale a design measurement to the current viewport.
  static double scale(BuildContext context, double designValue) =>
      designValue * scaleFactor(context);

  /// A [TextScaler] that respects the user's setting but caps it.
  static TextScaler cappedTextScaler(BuildContext context) {
    final TextScaler current = MediaQuery.textScalerOf(context);
    return TextScaler.linear(
      current.scale(1).clamp(1.0, _maxTextScale),
    );
  }
}
