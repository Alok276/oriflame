import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/constants/app_strings.dart';
import 'core/theme/app_theme.dart';
import 'features/smart_post/controllers/smart_post_controller.dart';
import 'routes/app_router.dart';

/// The root widget: theme, provider scope and the route table.
class SmartPostApp extends StatelessWidget {
  const SmartPostApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SmartPostController>(
      create: (_) => SmartPostController(),
      child: MaterialApp(
        title: AppStrings.appName,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        initialRoute: AppRouter.initialRoute,
        routes: AppRouter.routes,
      ),
    );
  }
}
