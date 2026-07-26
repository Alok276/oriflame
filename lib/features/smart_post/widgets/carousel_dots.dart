import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

/// The vertical dot indicator on the right edge of a post, one dot per image.
class CarouselDots extends StatelessWidget {
  const CarouselDots({
    required this.count,
    required this.currentIndex,
    super.key,
  });

  final int count;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        for (int i = 0; i < count; i++)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 6,
              height: i == currentIndex ? 16 : 6,
              decoration: BoxDecoration(
                color: i == currentIndex
                    ? AppColors.textWhite
                    : AppColors.glass,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
      ],
    );
  }
}
