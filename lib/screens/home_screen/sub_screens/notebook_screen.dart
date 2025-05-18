// notebook_screen.dart
import 'package:flutter/material.dart';
import 'package:task_manager/services/database_services/note_service.dart';
import 'package:task_manager/models/note.dart';

class NotebookScreen extends StatefulWidget {
  @override
  _NotebookScreenState createState() => _NotebookScreenState();
}

class _NotebookScreenState extends State<NotebookScreen> {
  final NoteService _noteService = NoteService();
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notebook"),
      ),
      body: Column(
        children: [
          // Text Field for Adding Notes
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: "Enter note content",
                suffixIcon: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _addNote,
                ),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<List<Note>>(
              stream: _noteService.getNotes(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text("No notes available"));
                }

                final notes = snapshot.data!;
                return ListView.builder(
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    final note = notes[index];
                    return ListTile(
                      title: Text(note.content),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _noteService.deleteNote(note.id!);
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _addNote() {
    if (_controller.text.isNotEmpty) {
      final note = Note(
        content: _controller.text,
      );
      _noteService.addNote(note);
      _controller.clear();
    }
  }
}
