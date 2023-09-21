import 'dart:convert';

class Note {
  final DateTime createdAt;
  final DateTime lastChangeDate;
  final String noteTitle;
  final String noteContent;

  Note({
    required this.createdAt,
    required this.lastChangeDate,
    required this.noteTitle,
    required this.noteContent,
  });

  Note._fromMap(Map raw)
      : createdAt = DateTime.parse(raw["createdAt"]),
        lastChangeDate = DateTime.parse(raw["lastChangeDate"]),
        noteContent = raw["noteContent"],
        noteTitle = raw["noteTitle"];

  Note copyWith({
    DateTime? createdAt,
    DateTime? lastChangeDate,
    String? noteTitle,
    String? noteContent,
  }) {
    return Note(
      createdAt: createdAt ?? this.createdAt,
      lastChangeDate: lastChangeDate ?? this.lastChangeDate,
      noteContent: noteContent ?? this.noteContent,
      noteTitle: noteTitle ?? this.noteTitle,
    );
  }

  String serialize() {
    return jsonEncode({
      "createdAt": createdAt.toIso8601String(),
      "lastChangeDate": lastChangeDate.toIso8601String(),
      "noteTitle": noteTitle,
      "noteContent": noteContent,
    });
  }

  static Note deserialize(String serializedNote) {
    Map raw = jsonDecode(serializedNote);
    return Note._fromMap(raw);
  }
}

