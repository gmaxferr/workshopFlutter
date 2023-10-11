import 'dart:convert';

import 'package:equatable/equatable.dart';

class Note extends Equatable {
  final DateTime createdAt;
  final DateTime lastChangeDate;
  final String noteTitle;
  final String noteContent;
  late final String _id;

  Note({
    required this.createdAt,
    required this.lastChangeDate,
    required this.noteTitle,
    required this.noteContent,
  }) {
    _id = "${DateTime.now().millisecondsSinceEpoch}";
  }

  Note.empty()
      : _id = "EMPTY",
        createdAt = DateTime(0),
        lastChangeDate = DateTime(0),
        noteContent = "",
        noteTitle = "";

  String get id => _id;

  Note._forceId({
    required String id,
    required this.createdAt,
    required this.lastChangeDate,
    required this.noteTitle,
    required this.noteContent,
  }) {
    _id = id;
  }
  
  Note._fromMap(Map raw)
      : _id = raw["_id"],
        createdAt = DateTime.parse(raw["createdAt"]),
        lastChangeDate = DateTime.parse(raw["lastChangeDate"]),
        noteContent = raw["noteContent"],
        noteTitle = raw["noteTitle"];

  Note copyWith({
    DateTime? createdAt,
    DateTime? lastChangeDate,
    String? noteTitle,
    String? noteContent,
  }) {
    return Note._forceId(
      id: _id,
      createdAt: createdAt ?? this.createdAt,
      lastChangeDate: lastChangeDate ?? this.lastChangeDate,
      noteContent: noteContent ?? this.noteContent,
      noteTitle: noteTitle ?? this.noteTitle,
    );
  }

  String serialize() {
    return jsonEncode({
      "_id": _id,
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

  @override
  List<Object?> get props => [
        _id,
        createdAt,
        lastChangeDate,
        noteContent,
        noteTitle,
      ];
}
