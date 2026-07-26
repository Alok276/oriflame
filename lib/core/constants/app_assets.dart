/// Every image and icon path in one place.
///
/// Widgets load these through `AppImage`, which draws a branded placeholder via
/// an `errorBuilder` when a file is missing — so the app builds and demos even
/// with gaps. Drop a real export in at the matching path and it appears with no
/// code change.
class AppAssets {
  const AppAssets._();

  static const String _images = 'assets/images';
  static const String _icons = 'assets/icons';

  // --------------------------------------------------------------- photos
  static const String post1 = '$_images/post_1.png';
  static const String post2 = '$_images/post_2.png';
  static const String post3 = '$_images/post_3.png';

  static const String avatar = '$_images/avatar.png';

  // ------------------------------------------------------------- products
  static const String productLipstick = '$_images/product_lipstick.png';
  static const String productLipBalm = '$_images/lip_balm.png';
  static const String productSerum = '$_images/face_serum.png';

  // --------------------------------------------------------------- brand
  static const String logo = '$_icons/oriflame_logo.png';
  static const String assistant = '$_icons/assistant.png';

  // ------------------------------------------------------------- nav icons
  static const String rocket = '$_icons/rocket.png';

  // ------------------------------------------------------ share buttons
  /// Pre-styled brand buttons for the "Quick share to:" strip.
  static const String shareInstagram = '$_icons/instagram.png';
  static const String shareFacebook = '$_icons/facebook.png';
  static const String shareWhatsapp = '$_icons/whatsapp.png';
  static const String shareWhatsappBusiness = '$_icons/whatsapp_business.png';
  static const String shareTelegram = '$_icons/telegram.png';
  static const String shareTiktok = '$_icons/image.png';
  static const String shareOriflame = '$_icons/oriflame_share.png';
}
