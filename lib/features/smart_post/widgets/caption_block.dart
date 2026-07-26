import 'package:flutter/material.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../data/models/smart_post.dart';
import '../../../shared/widgets/ai_badge.dart';

/// The caption, with an in-place "see more" toggle and an edit affordance.
///
/// Canvas notes: "see more" expands the caption without navigating (so the user
/// keeps their place in the feed); tapping the caption body opens the editor.
class CaptionBlock extends StatefulWidget {
  const CaptionBlock({
    required this.post,
    required this.caption,
    required this.onEdit,
    super.key,
  });

  final SmartPost post;
  final String caption;
  final VoidCallback onEdit;

  @override
  State<CaptionBlock> createState() => _CaptionBlockState();
}

class _CaptionBlockState extends State<CaptionBlock> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          children: <Widget>[
            const AiBadge(),
            const SizedBox(width: AppSpacing.xs),
            Text(
              AppStrings.captionSuggestion,
              style: AppTypography.label.copyWith(color: AppColors.textWhite),
            ),
            const Spacer(),
            _EditButton(onTap: widget.onEdit),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
        GestureDetector(
          onTap: widget.onEdit,
          behavior: HitTestBehavior.opaque,
          child: AnimatedCrossFade(
            duration: const Duration(milliseconds: 200),
            crossFadeState: _expanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            firstChild: _captionText(maxLines: 2),
            secondChild: _captionText(),
          ),
        ),
        if (_expanded) ...<Widget>[
          const SizedBox(height: AppSpacing.sm),
          _referralLine(
            AppStrings.referralCodePrefix,
            widget.post.referralCode,
          ),
          _referralLine(
            AppStrings.referralLinkPrefix,
            widget.post.referralLink,
          ),
        ],
        GestureDetector(
          onTap: () => setState(() => _expanded = !_expanded),
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding: const EdgeInsets.only(top: AppSpacing.xs),
            child: Text(
              _expanded ? AppStrings.seeLess : AppStrings.seeMore,
              style: AppTypography.caption.copyWith(
                color: AppColors.textWhite,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _captionText({int? maxLines}) {
    return Text(
      widget.caption,
      maxLines: maxLines,
      overflow: maxLines == null ? TextOverflow.clip : TextOverflow.ellipsis,
      style: AppTypography.body.copyWith(color: AppColors.textOnMedia),
    );
  }

  Widget _referralLine(String prefix, String value) {
    return Padding(
      padding: const EdgeInsets.only(top: 2),
      child: RichText(
        text: TextSpan(
          style: AppTypography.caption.copyWith(
            color: AppColors.textOnMedia,
            fontStyle: FontStyle.italic,
          ),
          children: <TextSpan>[
            TextSpan(text: prefix),
            TextSpan(
              text: value,
              style: AppTypography.caption.copyWith(
                color: AppColors.textWhite,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EditButton extends StatelessWidget {
  const _EditButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Icon(Icons.edit_outlined, size: 14, color: AppColors.textWhite),
          const SizedBox(width: AppSpacing.xs),
          Text(
            AppStrings.editCaptionCta,
            style: AppTypography.label.copyWith(color: AppColors.textWhite),
          ),
        ],
      ),
    );
  }
}
