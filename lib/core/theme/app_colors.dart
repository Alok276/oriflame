import 'package:flutter/material.dart';

/// Every colour used in the app.
///
/// Values tagged `[figma-var]` are bound variables in the design file. The
/// rest were sampled off the layers and are named here so that no widget ever
/// hard-codes a colour literal.73BF98
class AppColors {
  const AppColors._();

  // ---------------------------------------------------------------- brand
  /// [figma-var] Primary/Oriflame/600
  static const Color primary = Color(0xFF73BF98);
  static const Color primaryDark = Color(0xFF00503F);
  static const Color primarySoft = Color(0xFFE6F1EE);

  // ----------------------------------------------------------------- text
  /// [figma-var] Text/White
  static const Color textWhite = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF6E6E6E);
  static const Color textTertiary = Color(0xFF9B9B9B);

  /// White at 70% — secondary copy sitting on the photo overlay.
  static const Color textOnMedia = Color(0xB3FFFFFF);

  // -------------------------------------------------------------- surface
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceMuted = Color(0xFFF6F6F6);
  static const Color border = Color(0xFFE6E6E6);
  static const Color divider = Color(0xFFEFEFEF);

  /// Charcoal circle behind the header camera glyph.
  static const Color darkCircle = Color(0xFF333333);

  // -------------------------------------------------------------- overlay
  /// Frosted chips that sit directly on the post photo.
  static const Color glass = Color(0x33FFFFFF);
  static const Color glassStrong = Color(0x66000000);

  /// Scrim behind the generation overlay.
  static const Color scrim = Color(0x99000000);

  /// The bottom panel of a post card: transparent at the top so the photo
  /// bleeds through, near-solid at the bottom so the copy stays legible.
  static const List<Color> mediaScrim = <Color>[
    Color(0x00000000),
    Color(0xB3000000),
    Color(0xF2000000),
  ];

  // --------------------------------------------------------------- accent
  /// Discount pill ("30% off").
  static const Color discount = Color(0xFFD5006D);
  static const Color trending = Color(0xFFFFB020);

  /// Pink→purple gradient behind the "Ready to share" status chip.
  static const List<Color> readyToShareGradient = <Color>[
    Color(0xFFFF4D9D),
    Color(0xFF9D4EDD),
  ];

  // -------------------------------------------------------------- loading
  /// Soft peach/rose/violet tones for the generation-screen gradient band.
  static const Color blobPeach = Color(0xFFF8DFCD);
  static const Color blobRose = Color(0xFFF2C7D5);
  static const Color blobCream = Color(0xFFFBEBDF);
  static const Color blobViolet = Color(0xFFD9C2F0);

  // ------------------------------------------------------------ platforms
  /// Brand colours for the "Quick share to:" row, used as the circle fill
  /// when a brand glyph asset is unavailable.
  static const Color instagram = Color(0xFFE1306C);
  static const Color facebook = Color(0xFF1877F2);
  static const Color tiktok = Color(0xFF010101);
  static const Color whatsapp = Color(0xFF25D366);
  static const Color telegram = Color(0xFF229ED9);
  static const Color snapchat = Color(0xFFFFFC00);
  static const Color pinterest = Color(0xFFE60023);
}
