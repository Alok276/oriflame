import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/responsive.dart';
import '../../../data/models/share_platform.dart';
import '../../../data/models/smart_post.dart';
import '../../../shared/widgets/bottom_nav_bar.dart';
import '../../edit_caption/screens/edit_caption_screen.dart';
import '../../generation/screens/generation_overlay.dart';
import '../../share/screens/share_flow_sheet.dart';
import '../controllers/smart_post_controller.dart';
import '../widgets/post_feed.dart';
import '../widgets/smart_post_header.dart';
import '../widgets/smart_post_tabs.dart';

class SmartPostScreen extends StatefulWidget {
  const SmartPostScreen({super.key});

  static const String routeName = '/';

  @override
  State<SmartPostScreen> createState() => _SmartPostScreenState();
}

class _SmartPostScreenState extends State<SmartPostScreen> {
  final PageController _feedController = PageController();

  @override
  void dispose() {
    _feedController.dispose();
    super.dispose();
  }

  Future<void> _editCaption(SmartPost post) async {
    final SmartPostController controller = context.read<SmartPostController>();

    final String? updated = await Navigator.of(context).push<String>(
      MaterialPageRoute<String>(
        builder: (_) =>
            EditCaptionScreen(initialCaption: controller.captionFor(post)),
      ),
    );

    if (updated == null || !mounted) return;
    controller.updateCaption(post, updated);
    _toast(AppStrings.captionSaved);
  }

  /// No URL launcher is wired up — the brief asks for UI only, so the
  /// destination is surfaced instead of opened.
  void _openProduct(SmartPost post) =>
      _toast('Opening ${post.product.name} — ${post.product.storeUrl}');

  void _pickMusic(SmartPost post) =>
      _toast('Music picker: ${post.track.displayName}');

  Future<void> _share(SmartPost post, SharePlatform platform) async {
    await ShareFlow.start(context, platform);
    if (!context.mounted) return;
    _toast('Shared "${post.product.name}" to ${platform.label}');
  }

  void _toast(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final SmartPostController controller = context.watch<SmartPostController>();

    // Cap text scaling — the card is dense and unbounded scaling overflows it.
    return MediaQuery(
      data: MediaQuery.of(
        context,
      ).copyWith(textScaler: Responsive.cappedTextScaler(context)),
      child: Scaffold(
        body: SafeArea(
          bottom: false,
          // The generation flow is a full-area takeover under the header/tabs,
          // matching the prototype: no feed and no bottom nav while it runs.
          child: Column(
            children: <Widget>[
              const SizedBox(height: AppSpacing.sm),
              SmartPostHeader(
                onAssistantTap: () => _toast(AppStrings.assistant),
                onCameraTap: () => _toast(AppStrings.camera),
              ),
              SmartPostTabs(
                currentIndex: controller.topTabIndex,
                onChanged: controller.setTopTab,
              ),
              Expanded(
                child: controller.isGenerating
                    ? GenerationOverlay(
                        onCompleted: controller.completeGeneration,
                      )
                    : Stack(
                        children: <Widget>[
                          // Full-bleed feed — the photo runs to the bottom,
                          // behind the floating nav.
                          Positioned.fill(
                            child: _FeedConstraint(
                              child: PostFeed(
                                controller: _feedController,
                                posts: controller.posts,
                                captionFor: controller.captionFor,
                                platforms: controller.platforms,
                                activeIndex: controller.currentPostIndex,
                                onPageChanged: controller.setCurrentPost,
                                onEditCaption: _editCaption,
                                onOpenProduct: _openProduct,
                                onPickMusic: _pickMusic,
                                onShare: _share,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            right: 0,
                            bottom: 0,
                            child: BottomNavBar(
                              currentIndex: controller.bottomTabIndex,
                              onChanged: controller.setBottomTab,
                            ),
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// On tablets and desktop the feed keeps a phone-width column centred rather
/// than stretching a portrait photo across the viewport.
class _FeedConstraint extends StatelessWidget {
  const _FeedConstraint({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (!Responsive.isWide(context)) return child;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 480),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: AppColors.scrim,
                blurRadius: 24,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}
