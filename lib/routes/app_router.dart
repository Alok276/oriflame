import 'package:flutter/material.dart';

import '../features/smart_post/screens/smart_post_screen.dart';

/// The named-route table.
///
/// The app is a single screen; the caption editor is pushed imperatively with
/// a result, so it is not registered here. This table is the seam where more
/// destinations would be added.
class AppRouter {
  const AppRouter._();

  static const String initialRoute = SmartPostScreen.routeName;

  static Map<String, WidgetBuilder> get routes => <String, WidgetBuilder>{
        SmartPostScreen.routeName: (_) => const SmartPostScreen(),
      };
}
