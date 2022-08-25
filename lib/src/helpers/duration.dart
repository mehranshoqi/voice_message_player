/// document will be added
class VoiceDuration {
  /// document will be added
  static String getDuration(int duration) => duration < 60
      ? '00:$duration'
      : '${duration ~/ 60}:${duration % 60}';
}
