import '../../core/constants/app_assets.dart';
import '../models/music_track.dart';
import '../models/product.dart';
import '../models/smart_post.dart';

/// The three posts the feed shows. Per the brief, everything is hardcoded —
/// this file is the only place that would be swapped for a repository call.
class MockPosts {
  const MockPosts._();

  static const List<SmartPost> all = <SmartPost>[
    SmartPost(
      id: 'post-1',
      imagePaths: <String>[
        AppAssets.post1,
        AppAssets.post2,
        AppAssets.post3,
      ],
      authorAvatarPath: AppAssets.avatar,
      tagLabel: 'Ready to share',
      communityNote: 'High-converting in Oriflame Community',
      product: Product(
        id: 'giordani-gold-lipstick',
        name: 'Giordani Gold Lipstick',
        price: r'$14.99',
        imagePath: AppAssets.productLipstick,
        storeUrl: 'https://www.oriflame.com/giordani/amanda3012',
        discountLabel: '30% off',
        isTrending: true,
        trendingLabel: 'Trending right now and on sale',
      ),
      track: MusicTrack(title: 'Bad Habits', artist: 'Ed Sheeran'),
      caption:
          '\u{1F484} Elevate your beauty with the Giordani Gold - Eternal Glow '
          'Lipstick SPF 25! This luxurious creamy lipstick doesn\'t just promise '
          'rich pigments but brings you the benefits of hyaluronic acid and '
          'collagen-boosting peptides too. Pamper your lips with care while '
          'enjoying a long-lasting, luminous matte colour. \u{1F48B} ✨ '
          '#Oriflame #GiordaniGold #LipCareGoals',
      referralCode: 'UK-AMANDA3012',
      referralLink: 'www.oriflame.com/giordani/amanda3012',
    ),
    SmartPost(
      id: 'post-2',
      imagePaths: <String>[
        AppAssets.post2,
        AppAssets.post3,
        AppAssets.post1,
      ],
      authorAvatarPath: AppAssets.avatar,
      tagLabel: 'Ready to share',
      communityNote: 'Loved by 2.4k consultants this week',
      product: Product(
        id: 'hyaluronic-lip-balm',
        name: 'Hyaluronic Lip Balm',
        price: r'$9.49',
        imagePath: AppAssets.productLipBalm,
        storeUrl: 'https://www.oriflame.com/lipbalm/amanda10390',
        discountLabel: '15% off',
        isTrending: false,
      ),
      track: MusicTrack(title: 'As It Was', artist: 'Harry Styles'),
      caption:
          '\u{1F4A7} Keep your lips soft, plump, and perfectly hydrated all day! '
          'Our Hyaluronic Lip Balm is infused with moisture-locking ingredients '
          'to nourish, smooth, and add a natural, glossy finish. Say goodbye to '
          'dryness and hello to a luscious, healthy pout! \u{1F48B}✨ '
          '#HydratedLips #PlumpAndGlow #LipCare',
      referralCode: 'AMAOR3203',
      referralLink: 'www.oriflame.com/lipbalm/amanda10390',
    ),
    SmartPost(
      id: 'post-3',
      imagePaths: <String>[
        AppAssets.post3,
        AppAssets.post1,
        AppAssets.post2,
      ],
      authorAvatarPath: AppAssets.avatar,
      tagLabel: 'Ready to share',
      communityNote: 'Top performer in your region',
      product: Product(
        id: 'novage-glow-serum',
        name: 'NovAge Glow Serum',
        price: r'$32.00',
        imagePath: AppAssets.productSerum,
        storeUrl: 'https://www.oriflame.com/novage/amanda3012',
        isTrending: true,
        trendingLabel: 'Selling fast in your community',
      ),
      track: MusicTrack(title: 'Flowers', artist: 'Miley Cyrus'),
      caption:
          '✨ Wake your skin up. NovAge Glow Serum layers vitamin C with a '
          'triple-hydration complex for visibly brighter skin in 14 days. One '
          'pump, morning and night — that is the whole routine. '
          '#NovAge #GlowUp #SkincareThatWorks',
      referralCode: 'UK-AMANDA3012',
      referralLink: 'www.oriflame.com/novage/amanda3012',
    ),
  ];
}
