/// A suggested audio track for a post ("RECOMMENDED: …").
class MusicTrack {
  const MusicTrack({
    required this.title,
    required this.artist,
  });

  final String title;
  final String artist;

  /// How the track reads in the music row: "Title • Artist".
  String get displayName => '$title • $artist';
}
