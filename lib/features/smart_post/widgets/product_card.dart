import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../data/models/product.dart';
import '../../../shared/widgets/app_image.dart';
import '../../../shared/widgets/discount_badge.dart';

/// The product block on a post: thumbnail, name, and either the trending line
/// or the price, with the discount pill appended.
///
/// Canvas note: "This whole box is clickable → personal beauty store."
class ProductCard extends StatelessWidget {
  const ProductCard({
    required this.product,
    required this.onTap,
    super.key,
  });

  final Product product;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'Open ${product.name} in your store',
      child: Material(
        color: AppColors.glass,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.sm),
            child: Row(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                  child: AppImage(
                    path: product.imagePath,
                    width: AppSizes.productThumb,
                    height: AppSizes.productThumb,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(child: _details()),
                const SizedBox(width: AppSpacing.sm),
                const Icon(
                  Icons.chevron_right,
                  color: AppColors.textWhite,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _details() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          product.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTypography.title.copyWith(color: AppColors.textWhite),
        ),
        const SizedBox(height: AppSpacing.xs),
        Row(
          children: <Widget>[
            Flexible(
              child: product.isTrending && product.trendingLabel != null
                  ? _trendingLine(product.trendingLabel!)
                  : Text(
                      product.price,
                      style: AppTypography.price.copyWith(
                        color: AppColors.textWhite,
                      ),
                    ),
            ),
            if (product.hasDiscount) ...<Widget>[
              const SizedBox(width: AppSpacing.sm),
              DiscountBadge(label: product.discountLabel!),
            ],
          ],
        ),
      ],
    );
  }

  Widget _trendingLine(String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const Icon(
          Icons.trending_up,
          size: 14,
          color: AppColors.trending,
        ),
        const SizedBox(width: AppSpacing.xs),
        Flexible(
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.caption.copyWith(color: AppColors.trending),
          ),
        ),
      ],
    );
  }
}
