import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';

/// The full-screen generation flow shown on first load.
///
/// Matches the prototype: a soft peach/rose gradient blob behind a centred,
/// rotating status line ("Picking the best content for you…" →). The header and
/// tabs stay visible above it (owned by the screen); this widget fills the area
/// beneath them. [onCompleted] fires after the last line holds briefly.
/// Reduce-motion skips straight to completion.
class GenerationOverlay extends StatefulWidget {
  const GenerationOverlay({required this.onCompleted, super.key});

  final VoidCallback onCompleted;

  /// Per-character typing speed.
  static const Duration typeSpeed = Duration(milliseconds: 45);

  /// Per-character backspacing speed — much faster than typing.
  static const Duration deleteSpeed = Duration(milliseconds: 16);

  /// Hold once a line is fully typed, before backspacing / finishing.
  static const Duration holdFull = Duration(milliseconds: 750);

  /// Brief pause after a line is cleared, before the next types in.
  static const Duration holdEmpty = Duration(milliseconds: 120);

  @override
  State<GenerationOverlay> createState() => _GenerationOverlayState();
}

class _GenerationOverlayState extends State<GenerationOverlay>
    with SingleTickerProviderStateMixin {
  static const List<String> _lines = AppStrings.generationSteps;

  late final AnimationController _blob = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 6),
  );

  Timer? _timer;
  int _line = 0;
  int _chars = 0;
  bool _deleting = false;
  bool _started = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_started) return;
    _started = true;

    // Respect reduce-motion: skip the sequence and the looping blob.
    if (MediaQuery.disableAnimationsOf(context)) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _finish());
      return;
    }

    _blob.repeat(reverse: true);
    _tick();
  }

  /// Drives the typewriter: type a line, hold, backspace it fast, then type the
  /// next; finish after the last line is fully typed and held.
  void _tick() {
    final String full = _lines[_line];

    if (!_deleting) {
      if (_chars < full.length) {
        setState(() => _chars++);
        _timer = Timer(GenerationOverlay.typeSpeed, _tick);
      } else if (_line == _lines.length - 1) {
        _timer = Timer(GenerationOverlay.holdFull, _finish);
      } else {
        _timer = Timer(GenerationOverlay.holdFull, () {
          _deleting = true;
          _tick();
        });
      }
    } else {
      if (_chars > 0) {
        setState(() => _chars--);
        _timer = Timer(GenerationOverlay.deleteSpeed, _tick);
      } else {
        _deleting = false;
        _line++;
        _timer = Timer(GenerationOverlay.holdEmpty, _tick);
      }
    }
  }

  void _finish() {
    if (mounted) widget.onCompleted();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _blob.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.surface,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned.fill(child: _Blob(animation: _blob)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            // Typewriter: the visible slice of the current line, typed in and
            // rapidly backspaced out between messages.
            child: Text(
              _lines[_line].substring(0, _chars),
              textAlign: TextAlign.center,
              style: AppTypography.display.copyWith(height: 1.25),
            ),
          ),
        ],
      ),
    );
  }
}

/// The soft gradient band behind the status text.
///
/// Four large blurred discs are placed along a diagonal so, once blurred, they
/// read as an S-shaped colour ribbon. The whole band drifts horizontally
/// (right → left) on a slow loop.
class _Blob extends StatelessWidget {
  const _Blob({required this.animation});

  final Animation<double> animation;

  /// Base positions forming the S diagonal (alignment space, -1..1).
  static const List<_Disc> _discs = <_Disc>[
    _Disc(AppColors.blobCream, Alignment(0.6, -0.75), 280),
    _Disc(AppColors.blobPeach, Alignment(-0.05, -0.25), 300),
    _Disc(AppColors.blobRose, Alignment(-0.35, 0.3), 280),
    _Disc(AppColors.blobViolet, Alignment(0.45, 0.8), 260),
  ];

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: ClipRect(
        child: ImageFiltered(
          imageFilter: ImageFilter.blur(sigmaX: 70, sigmaY: 70),
          child: AnimatedBuilder(
            animation: animation,
            builder: (BuildContext context, _) {
              // Drift the band from right to left as the loop runs.
              final double drift = (0.5 - animation.value) * 0.9;
              return Stack(
                children: <Widget>[
                  for (final _Disc disc in _discs)
                    Align(
                      alignment: Alignment(
                        disc.alignment.x + drift,
                        disc.alignment.y,
                      ),
                      child: Container(
                        width: disc.size,
                        height: disc.size,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: disc.color,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _Disc {
  const _Disc(this.color, this.alignment, this.size);

  final Color color;
  final Alignment alignment;
  final double size;
}
