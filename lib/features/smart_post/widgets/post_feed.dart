import 'package:flutter/material.dart';

import '../../../data/models/share_platform.dart';
import '../../../data/models/smart_post.dart';
import 'post_card.dart';

/// The reels-style feed: a vertical, snapping [PageView] of [PostCard]s.
///
/// Canvas note: "Show 3 posts — user can scroll like reels."
class PostFeed extends StatelessWidget {
  const PostFeed({
    required this.controller,
    required this.posts,
    required this.captionFor,
    required this.platforms,
    required this.activeIndex,
    required this.onPageChanged,
    required this.onEditCaption,
    required this.onOpenProduct,
    required this.onPickMusic,
    required this.onShare,
    super.key,
  });

  final PageController controller;
  final List<SmartPost> posts;
  final String Function(SmartPost) captionFor;
  final List<SharePlatform> platforms;
  final int activeIndex;
  final ValueChanged<int> onPageChanged;
  final ValueChanged<SmartPost> onEditCaption;
  final ValueChanged<SmartPost> onOpenProduct;
  final ValueChanged<SmartPost> onPickMusic;
  final void Function(SmartPost, SharePlatform) onShare;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: controller,
      scrollDirection: Axis.vertical,
      onPageChanged: onPageChanged,
      itemCount: posts.length,
      itemBuilder: (BuildContext context, int index) {
        final SmartPost post = posts[index];
        return PostCard(
          post: post,
          caption: captionFor(post),
          platforms: platforms,
          index: index,
          total: posts.length,
          isActive: index == activeIndex,
          onEditCaption: () => onEditCaption(post),
          onOpenProduct: () => onOpenProduct(post),
          onPickMusic: () => onPickMusic(post),
          onShare: (SharePlatform platform) => onShare(post, platform),
        );
      },
    );
  }
}
