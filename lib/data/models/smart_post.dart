import 'music_track.dart';
import 'product.dart';

/// One AI-generated post in the reels-style feed.
class SmartPost {
  const SmartPost({
    required this.id,
    required this.imagePaths,
    required this.authorAvatarPath,
    required this.tagLabel,
    required this.communityNote,
    required this.product,
    required this.track,
    required this.caption,
    required this.referralCode,
    required this.referralLink,
  });

  final String id;

  /// The carousel of photos inside the post.
  final List<String> imagePaths;

  final String authorAvatarPath;

  /// e.g. "Best seller" — the chip beside the avatar.
  final String tagLabel;

  /// e.g. "High-converting in Oriflame Community".
  final String communityNote;

  final Product product;
  final MusicTrack track;

  /// The generated caption body.
  final String caption;

  final String referralCode;
  final String referralLink;

  /// The editable caption body. The referral code and link are rendered as
  /// their own lines beneath it (see [CaptionBlock]), matching the design,
  /// rather than being baked into the editable text.
  String get fullCaption => caption;
}
