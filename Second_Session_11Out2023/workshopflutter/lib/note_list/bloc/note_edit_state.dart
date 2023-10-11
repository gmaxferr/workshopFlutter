part of 'note_edit_bloc.dart';

class NoteEditState extends Equatable {
  final Note noteToEdit;
  final String updatedTitle;
  final String updatedContent;

  const NoteEditState({
    required this.noteToEdit,
    this.updatedTitle = "",
    this.updatedContent = "",
  });

  NoteEditState copyWith({
    Note? noteToEdit,
    String? updatedTitle,
    String? updatedContent,
  }) {
    return NoteEditState(
      noteToEdit: noteToEdit ?? this.noteToEdit,
      updatedTitle: updatedTitle ?? this.updatedTitle,
      updatedContent: updatedContent ?? this.updatedContent,
    );
  }

  @override
  List<Object?> get props => [noteToEdit, updatedTitle, updatedContent];
}
