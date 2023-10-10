import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workshopflutter/language/blocs/language_bloc.dart';
import 'package:workshopflutter/language/models/language_model.dart';
import 'package:workshopflutter/note_list/bloc/note_list_bloc.dart';
import 'package:workshopflutter/main.dart';
import 'package:workshopflutter/note_list/models/note.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NoteListPage extends StatefulWidget {
  const NoteListPage({super.key});

  @override
  State<NoteListPage> createState() => _NoteListPageState();
}

class _NoteListPageState extends State<NoteListPage> {
  void _insertNote() async {
    Note? note = await showDialog<Note>(
        context: context,
        builder: (BuildContext context) {
          final TextEditingController titleController = TextEditingController();
          final TextEditingController contentController =
              TextEditingController();
          return Dialog(
            backgroundColor: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                    AppLocalizations.of(context)!
                        .noteListPage_createNote_dialogTitle,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    children: [
                      TextField(
                        controller: titleController,
                        decoration: InputDecoration(
                            label: Text(AppLocalizations.of(context)!
                                .noteListPage_createNote_title),
                            border: const OutlineInputBorder()),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: contentController,
                        decoration: InputDecoration(
                            label: Text(AppLocalizations.of(context)!
                                .noteListPage_createNote_content),
                            border: const OutlineInputBorder()),
                        maxLines: 5,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(AppLocalizations.of(context)!
                                  .noteListPage_createNote_cancel)),
                          const SizedBox(width: 20),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(
                                    context,
                                    Note(
                                      createdAt: DateTime.now(),
                                      lastChangeDate: DateTime.now(),
                                      noteTitle: titleController.text,
                                      noteContent: contentController.text,
                                    ));
                              },
                              child: Text(AppLocalizations.of(context)!
                                  .noteListPage_createNote_add)),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        });
    if (note != null) {
      serviceLocator.get<NoteListBloc>().add(NoteListEventCreateNote(
            title: note.noteTitle,
            content: note.noteContent,
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(AppLocalizations.of(context)!.noteListPage_title),
        leadingWidth: 130,
        leading: Center(
          child: BlocBuilder<NoteListBloc, NoteListState>(
            bloc: serviceLocator.get<NoteListBloc>(),
            buildWhen: (p, c) =>
                p.noteList != c.noteList || p.status != c.status,
            builder: (context, state) {
              return state.status == NoteListStatus.loading
                  ? const SizedBox()
                  : Text(AppLocalizations.of(context)!
                      .noteListPage_numberOfNotes(state.noteList.length));
            },
          ),
        ),
        actions: [
          BlocBuilder<LanguageBloc, LanguageState>(
            bloc: serviceLocator.get<LanguageBloc>(),
            buildWhen: (p, c) =>
                p.currentLanguage != c.currentLanguage ||
                p.availableLanguages != c.availableLanguages ||
                p.status != c.status,
            builder: (context, state) {
              return DropdownButton<LanguageModel>(
                value: state.currentLanguage,
                  items: state.availableLanguages
                      .map<DropdownMenuItem<LanguageModel>>(
                          (_) => DropdownMenuItem(
                                value: _,
                                child: Text(_.languageName),
                              ))
                      .toList(),
                  onChanged: (languageModel) {
                    serviceLocator
                        .get<LanguageBloc>()
                        .add(LanguageEventLanguageChanged(lang: languageModel));
                  });
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _insertNote,
        tooltip: AppLocalizations.of(context)!.noteListPage_createNote_tooltip,
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<NoteListBloc, NoteListState>(
        bloc: serviceLocator.get<NoteListBloc>(),
        buildWhen: (previous, current) =>
            previous.noteList != current.noteList ||
            previous.status != current.status,
        builder: (context, state) {
          return Center(
            child: state.noteList.isEmpty
                ? Text(AppLocalizations.of(context)!
                    .noteListPage_emptyNoteDescription)
                : ListView.builder(
                    itemCount: state.noteList.length,
                    itemBuilder: (context, index) {
                      final Note currentNote = state.noteList[index];
                      return SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                        "${AppLocalizations.of(context)!.noteListPage_title}:",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16)),
                                    const SizedBox(width: 5),
                                    Text(currentNote.noteTitle),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "${AppLocalizations.of(context)!.noteListPage_createNote_content}:",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(currentNote.noteContent),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "${AppLocalizations.of(context)!.noteListPage_createNote_createdAt}:",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(currentNote.createdAt
                                        .toIso8601String()),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "${AppLocalizations.of(context)!.noteListPage_createNote_lastChangeDate}:",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(currentNote.lastChangeDate
                                        .toIso8601String()),
                                  ],
                                )
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 15, left: 15),
                              child: IconButton.filled(
                                  color: Colors.red,
                                  onPressed: () => serviceLocator
                                      .get<NoteListBloc>()
                                      .add(NoteListEventDeleteNote(
                                          noteId: currentNote.id)),
                                  icon: const Icon(Icons.delete_forever,
                                      color: Colors.white)),
                            )
                          ],
                        ),
                      );
                    },
                  ),
          );
        },
      ),
    );
  }
}
