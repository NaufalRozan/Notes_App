import 'package:flutter/material.dart';

void main() {
  runApp(SimpleNotesApp());
}

class SimpleNotesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NoteList(),
    );
  }
}

class Note {
  final String title;
  final String content;

  Note({required this.title, required this.content});
}

class NoteList extends StatefulWidget {
  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  final List<Note> notes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _addNote();
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(notes[index].title),
            subtitle: Text(notes[index].content),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                _deleteNote(index);
              },
            ),
          );
        },
      ),
    );
  }

  void _addNote() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return AddNotePage();
      }),
    ).then((newNote) {
      if (newNote != null) {
        setState(() {
          notes.add(newNote);
        });
      }
    });
  }

  void _deleteNote(int index) {
    setState(() {
      notes.removeAt(index);
    });
  }
}

class AddNotePage extends StatefulWidget {
  @override
  _AddNotePageState createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(labelText: 'Contents of Note'),
              maxLines: 2,
            ),
            SizedBox(height: 10,),
            ElevatedButton(
              onPressed: () {
                if (_titleController.text.isNotEmpty &&
                    _contentController.text.isNotEmpty) {
                  Navigator.of(context).pop(
                    Note(
                      title: _titleController.text,
                      content: _contentController.text,
                    ),
                  );
                }
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
