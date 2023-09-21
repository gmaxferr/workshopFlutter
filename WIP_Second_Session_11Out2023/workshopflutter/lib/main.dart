import 'package:flutter/material.dart';
import 'package:workshopflutter/models/note.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'The Notes App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Note> _notes = [];

  void _insertNote() async {
    Note? note = await showDialog<Note>(
        context: context,
        builder: (BuildContext context) {
          final TextEditingController titleController = TextEditingController();
          final TextEditingController contentController = TextEditingController();
          return Dialog(
            backgroundColor: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("Insert Note", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(label: Text('Title')),
                ),
                TextField(
                  controller: contentController,
                  decoration: const InputDecoration(label: Text('Content')),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel")),
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
                        child: const Text("Add")),
                  ],
                )
              ],
            ),
          );
        });
    if (note != null) {
      _notes.add(note);
      if (mounted) setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _insertNote,
        tooltip: 'Insert Note',
        child: const Icon(Icons.add),
      ),
      body: Center(
        child: _notes.isEmpty
            ? const Text("Added notes will be listed here.")
            : ListView.builder(
                itemCount: _notes.length,
                itemBuilder: (context, index) {
                  final Note currentNote = _notes[index];
                  return SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text("Title:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            const SizedBox(width: 5),
                            Text(currentNote.noteTitle),
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              "Content:",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(width: 5),
                            Text(currentNote.noteContent),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
