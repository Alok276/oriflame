import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:oriflame/core/constants/app_strings.dart';
import 'package:oriflame/features/smart_post/controllers/smart_post_controller.dart';
import 'package:oriflame/features/generation/screens/generation_overlay.dart';
import 'package:oriflame/features/smart_post/screens/smart_post_screen.dart';
import 'package:oriflame/features/smart_post/widgets/post_feed.dart';
import 'package:oriflame/features/smart_post/widgets/smart_post_header.dart';

/// Pumps the screen inside the provider scope, with reduce-motion on so the
/// generation overlay resolves immediately instead of running its timers.
Future<void> _pumpScreen(WidgetTester tester) async {
  await tester.pumpWidget(
    ChangeNotifierProvider<SmartPostController>(
      create: (_) => SmartPostController(),
      child: const MediaQuery(
        data: MediaQueryData(disableAnimations: true),
        child: MaterialApp(home: SmartPostScreen()),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('feed renders the header and tabs once generation completes',
      (WidgetTester tester) async {
    await _pumpScreen(tester);

    expect(find.byType(SmartPostHeader), findsOneWidget);
    // The generation overlay should be gone once it completes.
    expect(find.byType(GenerationOverlay), findsNothing);
    // The feed and the first top tab are present.
    expect(find.byType(PostFeed), findsOneWidget);
    expect(find.text(AppStrings.topTabs.first), findsOneWidget);
  });

  testWidgets('tapping a section tab updates the controller',
      (WidgetTester tester) async {
    await _pumpScreen(tester);

    await tester.tap(find.text(AppStrings.topTabs[1]));
    await tester.pump();

    final SmartPostController controller =
        Provider.of<SmartPostController>(
      tester.element(find.byType(SmartPostScreen)),
      listen: false,
    );
    expect(controller.topTabIndex, 1);
  });
}
