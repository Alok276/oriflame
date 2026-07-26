import 'package:flutter/material.dart';

import '../../../shared/widgets/app_image.dart';

/// The horizontally-paged photos inside a single post.
///
/// Reports the visible page up to [PostCard] so the right-edge dots stay in
/// sync.
class PostImageCarousel extends StatefulWidget {
  const PostImageCarousel({
    required this.imagePaths,
    required this.onIndexChanged,
    super.key,
  });

  final List<String> imagePaths;
  final ValueChanged<int> onIndexChanged;

  @override
  State<PostImageCarousel> createState() => _PostImageCarouselState();
}

class _PostImageCarouselState extends State<PostImageCarousel> {
  final PageController _controller = PageController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _controller,
      onPageChanged: widget.onIndexChanged,
      itemCount: widget.imagePaths.length,
      itemBuilder: (BuildContext context, int index) => AppImage(
        path: widget.imagePaths[index],
        fit: BoxFit.cover,
      ),
    );
  }
}
