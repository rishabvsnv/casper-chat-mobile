class SavedMessage {
  final String text;
  final String time;
  final bool isSender;

  const SavedMessage({
    required this.text,
    required this.time,
    this.isSender = false,
  });
}
