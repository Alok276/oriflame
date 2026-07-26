import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

/// An asset image that degrades gracefully.
///
/// The Figma exports were not supplied, so any asset path may be missing. When
/// the asset fails to load, a branded gradient placeholder is drawn instead, so
/// the app builds and demos with an empty `assets/images/`. Drop the real
/// export in at the same path and it appears with no code change.
class AppImage extends StatelessWidget {
  const AppImage({
    required this.path,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    super.key,
  });

  final String path;
  final BoxFit fit;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      path,
      fit: fit,
      width: width,
      height: height,
      errorBuilder: (BuildContext context, Object error, StackTrace? stack) =>
          _Placeholder(width: width, height: height),
    );
  }
}

class _Placeholder extends StatelessWidget {
  const _Placeholder({this.width, this.height});

  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[AppColors.primary, AppColors.primaryDark],
        ),
      ),
      alignment: Alignment.center,
      child: const Icon(
        Icons.image_outlined,
        color: AppColors.glass,
        size: 40,
      ),
    );
  }
}
