/// All user-facing copy in one place.
///
/// Keeping strings here keeps widget files free of literals and makes the app
/// trivial to localise later.
class AppStrings {
  const AppStrings._();

  // --------------------------------------------------------------- header
  static const String appName = 'Oriflame';
  static const String assistant = 'Your Assistant';
  static const String camera = 'Camera';

  // ----------------------------------------------------------- top tabs
  static const List<String> topTabs = <String>[
    'Smart Post',
    'Library',
    'Communities',
    'Share & Win',
  ];

  // -------------------------------------------------------------- detail
  static const String recommended = 'RECOMMENDED';
  static const String caption = 'Caption';
  static const String captionSuggestion = 'Caption Suggestion';
  static const String seeMore = 'see more';
  static const String seeLess = 'see less';
  static const String edit = 'Edit';
  static const String editCaptionCta = 'Edit Caption';
  static const String quickShareTo = 'Quick share to:';
  static const String referralCodePrefix = 'Use my referral code: ';
  static const String referralLinkPrefix = 'Use my referral link: ';

  // ------------------------------------------------------------ generation
  /// Rotating status lines shown during the full-screen generation flow.
  static const List<String> generationSteps = <String>[
    'Picking the best content\nfor you',
    'Finding the right music\nto match',
    'Writing captions\nin your voice',
    'Personalising it for\nyour community',
  ];

  // ------------------------------------------------------------ share flow
  /// Steps shown in the share loading card after a platform is tapped.
  static const List<String> shareSteps = <String>[
    'Generating your sales link',
    'Copying the caption to clipboard',
    'Saving the content to your profile',
    'Preparing the content for social media',
  ];
  static const String openingPrefix = 'Opening ';

  // --------------------------------------------------------- edit caption
  static const String editCaptionTitle = 'Edit caption';
  static const String save = 'Save';
  static const String captionSaved = 'Caption updated';
  static const String discardTitle = 'Discard changes?';
  static const String discardBody =
      'Your edits to this caption will be lost.';
  static const String discard = 'Discard';
  static const String keepEditing = 'Keep editing';

  // ---------------------------------------------------------------- misc
  static const String tapToOpenStore = 'Tap to open your beauty store';
}
