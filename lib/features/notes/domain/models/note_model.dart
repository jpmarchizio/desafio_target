class NoteModel {
  final String id;
  final String? title;
  final String content;
  final DateTime createdAt;

  const NoteModel({
    required this.id,
    this.title,
    required this.content,
    required this.createdAt,
  });

  String get displayTitle {
    final t = title;
    if (t != null) return t;

    final words = content.trim().split(' ');
    return words.length > 1 ? '${words.first}...' : words.first;
  }
}
