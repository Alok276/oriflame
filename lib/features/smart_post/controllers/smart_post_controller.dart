import 'package:flutter/foundation.dart';

import '../../../data/mock/mock_posts.dart';
import '../../../data/mock/mock_share_platforms.dart';
import '../../../data/models/share_platform.dart';
import '../../../data/models/smart_post.dart';

/// Screen state for the Smart Post feed.
///
/// A [ChangeNotifier] is the right weight here: one screen, a handful of
/// fields, no async data source. Swapping in a heavier state solution later
/// only touches this file.
class SmartPostController extends ChangeNotifier {
  SmartPostController({
    List<SmartPost>? posts,
    List<SharePlatform>? platforms,
  })  : _posts = posts ?? MockPosts.all,
        _platforms = platforms ?? MockSharePlatforms.all;

  final List<SmartPost> _posts;
  final List<SharePlatform> _platforms;

  /// Captions the user has edited, keyed by post id. The mock data stays
  /// immutable; this map is the override layer.
  final Map<String, String> _editedCaptions = <String, String>{};

  int _currentPostIndex = 0;
  int _topTabIndex = 0;
  int _bottomTabIndex = 0;
  bool _isGenerating = true;

  List<SmartPost> get posts => List<SmartPost>.unmodifiable(_posts);
  List<SharePlatform> get platforms =>
      List<SharePlatform>.unmodifiable(_platforms);

  int get currentPostIndex => _currentPostIndex;
  int get topTabIndex => _topTabIndex;
  int get bottomTabIndex => _bottomTabIndex;

  /// True while the generation overlay is on screen.
  bool get isGenerating => _isGenerating;

  SmartPost get currentPost => _posts[_currentPostIndex];

  /// The caption to render — the edited one if there is one.
  String captionFor(SmartPost post) =>
      _editedCaptions[post.id] ?? post.fullCaption;

  bool hasEdited(SmartPost post) => _editedCaptions.containsKey(post.id);

  void setCurrentPost(int index) {
    if (index == _currentPostIndex) return;
    _currentPostIndex = index;
    notifyListeners();
  }

  void setTopTab(int index) {
    if (index == _topTabIndex) return;
    _topTabIndex = index;
    notifyListeners();
  }

  void setBottomTab(int index) {
    if (index == _bottomTabIndex) return;
    _bottomTabIndex = index;
    notifyListeners();
  }

  void updateCaption(SmartPost post, String caption) {
    _editedCaptions[post.id] = caption;
    notifyListeners();
  }

  void completeGeneration() {
    if (!_isGenerating) return;
    _isGenerating = false;
    notifyListeners();
  }

  /// Lets the demo replay the generation sequence.
  void restartGeneration() {
    _isGenerating = true;
    notifyListeners();
  }
}
