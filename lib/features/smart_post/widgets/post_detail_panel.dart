import 'dart:async';

import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../data/models/share_platform.dart';
import '../../../data/models/smart_post.dart';
import 'caption_block.dart';
import 'music_row.dart';
import 'product_card.dart';
import 'quick_share_row.dart';

/// The overlay panel at the bottom of a post card.
///
/// Canvas note: the product info fades in from the bottom after 3 seconds,
/// reels-style. Only the product block animates in — the caption and share
/// row are present from the start so the card is never unusable while
/// waiting.
class PostDetailPanel extends StatefulWidget {
  const PostDetailPanel({
    required this.post,
    required this.caption,
    required this.platforms,
    required this.isActive,
    required this.onEditCaption,
    required this.onOpenProduct,
    required this.onPickMusic,
    required this.onShare,
    super.key,
  });

  final SmartPost post;
  final String caption;
  final List<SharePlatform> platforms;

  /// Only the visible card runs its reveal timer.
  final bool isActive;

  final VoidCallback onEditCaption;
  final VoidCallback onOpenProduct;
  final VoidCallback onPickMusic;
  final ValueChanged<SharePlatform> onShare;

  /// Canvas note: the product info fades in after 3 seconds.
  static const Duration revealDelay = Duration(seconds: 3);

  /// Duration of the rise-and-fade reveal itself.
  static const Duration revealAnimation = Duration(milliseconds: 500);

  @override
  State<PostDetailPanel> createState() => _PostDetailPanelState();
}

class _PostDetailPanelState extends State<PostDetailPanel> {
  Timer? _timer;
  bool _productVisible = false;

  @override
  void initState() {
    super.initState();
    if (widget.isActive) _scheduleReveal();
  }

  @override
  void didUpdateWidget(PostDetailPanel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive && !oldWidget.isActive) {
      _scheduleReveal();
    } else if (!widget.isActive && oldWidget.isActive) {
      _timer?.cancel();
      setState(() => _productVisible = false);
    }
  }

  void _scheduleReveal() {
    _timer?.cancel();
    _timer = Timer(PostDetailPanel.revealDelay, () {
      if (mounted) setState(() => _productVisible = true);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Respect the OS reduce-motion setting: show the block immediately.
    final bool reduceMotion = MediaQuery.disableAnimationsOf(context);
    final bool visible = _productVisible || reduceMotion;

    // Reserve room at the bottom for the floating nav bar (which sits over the
    // photo) plus the device's home-indicator inset.
    final double navReserve =
        60 + MediaQuery.viewPaddingOf(context).bottom;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        AppSpacing.gutter,
        AppSpacing.xxl,
        AppSpacing.gutter,
        navReserve,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: AppColors.mediaScrim,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: <double>[0, 0.35, 1],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // Reels-style reveal: the product box rises from below with a fade
          // and a subtle scale "pop". Only this block animates in.
          AnimatedSlide(
            duration: PostDetailPanel.revealAnimation,
            curve: Curves.easeOutCubic,
            offset: visible ? Offset.zero : const Offset(0, 0.6),
            child: AnimatedScale(
              duration: PostDetailPanel.revealAnimation,
              curve: Curves.easeOutBack,
              scale: visible ? 1 : 0.96,
              child: AnimatedOpacity(
                duration: PostDetailPanel.revealAnimation,
                curve: Curves.easeOut,
                opacity: visible ? 1 : 0,
                child: ProductCard(
                  product: widget.post.product,
                  onTap: widget.onOpenProduct,
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          MusicRow(track: widget.post.track, onTap: widget.onPickMusic),
          const SizedBox(height: AppSpacing.sm),
          CaptionBlock(
            post: widget.post,
            caption: widget.caption,
            onEdit: widget.onEditCaption,
          ),
          const SizedBox(height: AppSpacing.lg),
          QuickShareRow(
            platforms: widget.platforms,
            onShare: widget.onShare,
          ),
        ],
      ),
    );
  }
}
