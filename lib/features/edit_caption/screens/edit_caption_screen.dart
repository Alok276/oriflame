import 'package:flutter/material.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../widgets/save_button.dart';

/// Full-screen caption editor.
///
/// Canvas notes: opens when the caption is tapped; the keyboard opens on push
/// (the field autofocuses); Save enables once a change is made. Popping returns
/// the edited caption, or null if the user backs out unchanged / discards.
class EditCaptionScreen extends StatefulWidget {
  const EditCaptionScreen({required this.initialCaption, super.key});

  final String initialCaption;

  static const String routeName = '/edit-caption';

  @override
  State<EditCaptionScreen> createState() => _EditCaptionScreenState();
}

class _EditCaptionScreenState extends State<EditCaptionScreen> {
  late final TextEditingController _controller =
      TextEditingController(text: widget.initialCaption);

  bool get _isDirty => _controller.text.trim() != widget.initialCaption.trim();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _save() => Navigator.of(context).pop<String>(_controller.text.trim());

  Future<bool> _confirmDiscard() async {
    if (!_isDirty) return true;

    final bool? discard = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text(AppStrings.discardTitle),
        content: const Text(AppStrings.discardBody),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text(AppStrings.keepEditing),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: AppColors.discount),
            child: const Text(AppStrings.discard),
          ),
        ],
      ),
    );
    return discard ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        if (didPop) return;
        final bool shouldPop = await _confirmDiscard();
        if (!shouldPop || !context.mounted) return;
        Navigator.of(context).pop();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.editCaptionTitle),
          titleTextStyle: AppTypography.titleLarge,
          backgroundColor: AppColors.surface,
          foregroundColor: AppColors.textPrimary,
          elevation: 0,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.gutter),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _controller,
                    autofocus: true,
                    maxLines: null,
                    expands: true,
                    textAlignVertical: TextAlignVertical.top,
                    keyboardType: TextInputType.multiline,
                    style: AppTypography.body,
                    decoration: InputDecoration(
                      hintText: AppStrings.caption,
                      filled: true,
                      fillColor: AppColors.surfaceMuted,
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(AppSpacing.radiusMd),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.all(AppSpacing.gutter),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.gutter),
                SaveButton(enabled: _isDirty, onPressed: _save),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
