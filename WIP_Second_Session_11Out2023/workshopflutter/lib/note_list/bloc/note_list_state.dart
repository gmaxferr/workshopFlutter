part of 'note_list_bloc.dart';

class NoteListState extends Equatable {
  final List<Note> noteList;
  final NoteListStatus status;

  const NoteListState({
    this.noteList = const [],
    this.status = NoteListStatus.loaded,
  });

  NoteListState copyWith({
    List<Note>? noteList,
    NoteListStatus? status,
  }) {
    return NoteListState(
      noteList: noteList ?? this.noteList,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [noteList, status];
}
