import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/app_image.dart';
import '../../../shared/widgets/tag_chip.dart';

/// The author block on a post photo: avatar, a tag chip and the community note.
class PostAuthorHeader extends StatelessWidget {
  const PostAuthorHeader({
    required this.avatarPath,
    required this.tagLabel,
    required this.communityNote,
    super.key,
  });

  final String avatarPath;
  final String tagLabel;
  final String communityNote;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        ClipOval(
          child: AppImage(
            path: avatarPath,
            width: AppSizes.avatar,
            height: AppSizes.avatar,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TagChip(
                label: tagLabel,
                gradient: AppColors.readyToShareGradient,
                foreground: AppColors.textWhite,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                communityNote,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.bodyStrong.copyWith(
                  color: AppColors.textWhite,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
