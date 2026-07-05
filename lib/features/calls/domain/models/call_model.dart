class CallModel {
  final String name;
  final String time;
  final bool isIncoming;
  final bool isMissed;
  final bool isVideo;

  const CallModel({
    required this.name,
    required this.time,
    required this.isIncoming,
    required this.isMissed,
    required this.isVideo,
  });
}
