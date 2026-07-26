import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/constants/app_assets.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';

/// The bottom navigation.
///
/// Matches the "Ready for dev" frame: five unlabelled icons — discover, search,
/// home, messages, profile — with the active destination tinted brand green.
/// (The labels the earlier draft carried were ours; the design has none.)
class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    required this.currentIndex,
    required this.onChanged,
    super.key,
  });

  final int currentIndex;
  final ValueChanged<int> onChanged;

  static const List<_NavSpec> _items = <_NavSpec>[
    _NavSpec(
      Icons.rocket_launch_outlined,
      Icons.rocket_launch,
      'Discover',
      asset: AppAssets.rocket,
    ),
    _NavSpec(Icons.search_outlined, Icons.search, 'Search'),
    _NavSpec(Icons.home_outlined, Icons.home, 'Home'),
    _NavSpec(
      CupertinoIcons.chat_bubble,
      CupertinoIcons.chat_bubble_fill,
      'Messages',
    ),
    _NavSpec(
      CupertinoIcons.person_crop_circle,
      CupertinoIcons.person_crop_circle_fill,
      'Profile',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // The bar floats over the post photo, so it is transparent with a faint
    // scrim for legibility and white icons.
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[Color(0x00000000), Color(0x66000000)],
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              for (int i = 0; i < _items.length; i++)
                _NavItem(
                  spec: _items[i],
                  selected: i == currentIndex,
                  onTap: () => onChanged(i),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavSpec {
  const _NavSpec(this.icon, this.activeIcon, this.label, {this.asset});

  final IconData icon;
  final IconData activeIcon;
  final String label;

  /// Optional tinted PNG used instead of [icon]/[activeIcon].
  final String? asset;
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.spec,
    required this.selected,
    required this.onTap,
  });

  final _NavSpec spec;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    // White over the photo; the selected item is full-white with a dot marker.
    final Color tint = selected ? AppColors.textWhite : AppColors.textOnMedia;

    final Widget graphic = spec.asset != null
        ? Image.asset(
            spec.asset!,
            width: AppSizes.navIcon,
            height: AppSizes.navIcon,
            color: tint,
            errorBuilder: (_, _, _) => Icon(
              selected ? spec.activeIcon : spec.icon,
              size: AppSizes.navIcon,
              color: tint,
            ),
          )
        : Icon(
            selected ? spec.activeIcon : spec.icon,
            size: AppSizes.navIcon,
            color: tint,
          );

    return Semantics(
      button: true,
      selected: selected,
      label: spec.label,
      child: InkResponse(
        onTap: onTap,
        radius: 28,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            graphic,
            const SizedBox(height: 4),
            Container(
              width: 5,
              height: 5,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selected ? AppColors.textWhite : Colors.transparent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
