import 'package:flutter/material.dart';

import '../../../core/theme/app_spacing.dart';
import '../../../data/models/share_platform.dart';
import '../../../data/models/smart_post.dart';
import 'carousel_dots.dart';
import 'post_author_header.dart';
import 'post_counter_badge.dart';
import 'post_detail_panel.dart';
import 'post_image_carousel.dart';

/// One full-bleed card in the feed: photo carousel, the overlays sitting on
/// it, and the detail panel anchored to the bottom.
class PostCard extends StatefulWidget {
  const PostCard({
    required this.post,
    required this.caption,
    required this.platforms,
    required this.index,
    required this.total,
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

  /// Zero-based position in the feed.
  final int index;
  final int total;
  final bool isActive;

  final VoidCallback onEditCaption;
  final VoidCallback onOpenProduct;
  final VoidCallback onPickMusic;
  final ValueChanged<SharePlatform> onShare;

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  int _imageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          PostImageCarousel(
            imagePaths: widget.post.imagePaths,
            onIndexChanged: (int i) => setState(() => _imageIndex = i),
          ),

          // Author block, top-left.
          Positioned(
            top: AppSpacing.gutter,
            left: AppSpacing.gutter,
            right: 72,
            child: PostAuthorHeader(
              avatarPath: widget.post.authorAvatarPath,
              tagLabel: widget.post.tagLabel,
              communityNote: widget.post.communityNote,
            ),
          ),

          // "1 of 3", top-right.
          Positioned(
            top: AppSpacing.gutter,
            right: AppSpacing.gutter,
            child: PostCounterBadge(
              index: widget.index + 1,
              total: widget.total,
            ),
          ),

          // Carousel dots, right edge, vertically centred.
          Positioned(
            right: AppSpacing.gutter,
            top: 0,
            bottom: 0,
            child: Center(
              child: CarouselDots(
                count: widget.post.imagePaths.length,
                currentIndex: _imageIndex,
              ),
            ),
          ),

          // Detail panel, pinned to the bottom.
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: PostDetailPanel(
              post: widget.post,
              caption: widget.caption,
              platforms: widget.platforms,
              isActive: widget.isActive,
              onEditCaption: widget.onEditCaption,
              onOpenProduct: widget.onOpenProduct,
              onPickMusic: widget.onPickMusic,
              onShare: widget.onShare,
            ),
          ),
        ],
      ),
    );
  }
}
