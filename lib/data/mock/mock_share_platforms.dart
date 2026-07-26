import 'package:flutter/material.dart';

import '../../core/constants/app_assets.dart';
import '../../core/theme/app_colors.dart';
import '../models/share_platform.dart';

/// The destinations in the "Quick share to:" strip.
///
/// Each entry points at a pre-styled brand button under `assets/icons/`. The
/// [color] and [icon] are the fallback shown as a coloured circle if a button
/// image ever fails to load.
class MockSharePlatforms {
  const MockSharePlatforms._();

  static const List<SharePlatform> all = <SharePlatform>[
    SharePlatform(
      id: 'instagram',
      brand: 'Instagram',
      color: AppColors.instagram,
      icon: Icons.camera_alt_outlined,
      glyphPath: AppAssets.shareInstagram,
    ),
    SharePlatform(
      id: 'facebook',
      brand: 'Facebook',
      color: AppColors.facebook,
      icon: Icons.facebook,
      glyphPath: AppAssets.shareFacebook,
    ),
    SharePlatform(
      id: 'whatsapp',
      brand: 'WhatsApp',
      color: AppColors.whatsapp,
      icon: Icons.chat_bubble_outline,
      glyphPath: AppAssets.shareWhatsapp,
    ),
    SharePlatform(
      id: 'whatsapp-business',
      brand: 'WhatsApp Business',
      color: AppColors.whatsapp,
      icon: Icons.storefront_outlined,
      glyphPath: AppAssets.shareWhatsappBusiness,
    ),
    SharePlatform(
      id: 'telegram',
      brand: 'Telegram',
      color: AppColors.telegram,
      icon: Icons.send_outlined,
      glyphPath: AppAssets.shareTelegram,
    ),
    SharePlatform(
      id: 'tiktok',
      brand: 'TikTok',
      color: AppColors.tiktok,
      icon: Icons.music_note_outlined,
      glyphPath: AppAssets.shareTiktok,
    ),
    SharePlatform(
      id: 'oriflame',
      brand: 'Oriflame Community',
      color: AppColors.primary,
      icon: Icons.ios_share,
      glyphPath: AppAssets.shareOriflame,
    ),
  ];
}
