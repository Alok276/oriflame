import 'package:flutter/material.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../data/models/music_track.dart';

/// The suggested-audio row: "RECOMMENDED: Title • Artist", tappable to open the
/// (stubbed) music picker.
class MusicRow extends StatelessWidget {
  const MusicRow({
    required this.track,
    required this.onTap,
    super.key,
  });

  final MusicTrack track;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
        child: Row(
          children: <Widget>[
            const Icon(
              Icons.music_note,
              size: 16,
              color: AppColors.textWhite,
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: RichText(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textOnMedia,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: '${AppStrings.recommended}: ',
                      style: AppTypography.label.copyWith(
                        color: AppColors.textWhite,
                      ),
                    ),
                    TextSpan(
                      text: track.displayName,
                      style: AppTypography.caption.copyWith(
                        color: AppColors.textWhite,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Icon(
              Icons.keyboard_arrow_down,
              size: 18,
              color: AppColors.textOnMedia,
            ),
          ],
        ),
      ),
    );
  }
}
