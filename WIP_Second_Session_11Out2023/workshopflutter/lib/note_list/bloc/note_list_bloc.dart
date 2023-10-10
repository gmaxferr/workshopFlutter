import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:workshopflutter/note_list/models/note.dart';
import 'package:workshopflutter/note_list/repository/note_list_repository.dart';

part 'note_list_event.dart';
part 'note_list_state.dart';

enum NoteListStatus { loaded, loading }

@singleton
class NoteListBloc extends Bloc<NoteListEvent, NoteListState> {
  final NoteListRepository repository;

  NoteListBloc({required this.repository}) : super(const NoteListState()) {
    on<NoteListEventCreateNote>(_mapNoteListEventCreateNoteToState);
    on<NoteListEventDeleteNote>(_mapNoteListEventDeleteNoteToState);
    on<NoteListEventFetchAll>(_mapNoteListEventFetchaAllToState);
    on<NoteListEventUpdateNote>(_mapNoteListEventUpdateToState);

    add(const NoteListEventFetchAll());
  }

  FutureOr<void> _mapNoteListEventCreateNoteToState(
      NoteListEventCreateNote event, Emitter<NoteListState> emit) async {
    emit(state.copyWith(status: NoteListStatus.loading));

    await repository.saveNote(Note(
      createdAt: DateTime.now(),
      lastChangeDate: DateTime.now(),
      noteContent: event.content,
      noteTitle: event.title,
    ));

    add(const NoteListEventFetchAll());
  }

  FutureOr<void> _mapNoteListEventDeleteNoteToState(
      NoteListEventDeleteNote event, Emitter<NoteListState> emit) async {
    emit(state.copyWith(status: NoteListStatus.loading));

    await repository.deleteNote(event.noteId);

    add(const NoteListEventFetchAll());
  }

  FutureOr<void> _mapNoteListEventFetchaAllToState(
      NoteListEventFetchAll event, Emitter<NoteListState> emit) async {
    emit(state.copyWith(status: NoteListStatus.loading));

    List<Note> notes = await repository.loadNotes();

    emit(state.copyWith(
      noteList: notes,
      status: NoteListStatus.loaded,
    ));
  }

  FutureOr<void> _mapNoteListEventUpdateToState(
      NoteListEventUpdateNote event, Emitter<NoteListState> emit) async {
    emit(state.copyWith(status: NoteListStatus.loading));

    await repository.saveNote(event.updatedNote);
    add(const NoteListEventFetchAll());
  }
}
