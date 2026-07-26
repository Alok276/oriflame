/// The product promoted by a post, shown in the tappable product block.
///
/// Later frames show a trending line where earlier frames show a price. Rather
/// than stack both, the card shows [trendingLabel] when [isTrending] and the
/// [price] otherwise, with the discount pill appended in both cases.
class Product {
  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imagePath,
    required this.storeUrl,
    this.discountLabel,
    this.isTrending = false,
    this.trendingLabel,
  });

  final String id;
  final String name;

  /// Pre-formatted, e.g. `r'$14.99'`.
  final String price;

  final String imagePath;

  /// The consultant's personal store deep link. Surfaced, not launched —
  /// the brief is UI only.
  final String storeUrl;

  /// e.g. "30% off". Null when the product is not discounted.
  final String? discountLabel;

  final bool isTrending;

  /// e.g. "Trending right now and on sale". Shown in place of [price] when
  /// [isTrending] is true.
  final String? trendingLabel;

  bool get hasDiscount => discountLabel != null && discountLabel!.isNotEmpty;
}
