
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'note.dart';

class TestAddNoteScreen extends StatefulWidget {
  const TestAddNoteScreen({super.key});

  @override
  State<TestAddNoteScreen> createState() => _TestAddNoteScreenState();
}

class _TestAddNoteScreenState extends State<TestAddNoteScreen> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final imageController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  final firestore = FirebaseFirestore.instance;
  bool isFavorited = false;

  List<Note> myFavorite = [];

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Note"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(height: 10),
              IconButton(
                onPressed: () {
                  isFavorited
                      ? removeFromFavScreen(index)
                      : addToFavScreen();
                  setState(() => isFavorited = !isFavorited);
                },
                icon: isFavorited
                    ? Icon(Icons.favorite, color: Colors.red,)
                    : Icon(Icons.favorite_border),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: imageController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("image"),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "image required";
                  }

                  return null;
                },
              ),
              TextFormField(
                controller: titleController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Title"),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Title required";
                  }

                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: contentController,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Content"),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Content required";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => addNote(),
                  child: const Text("Add"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void addNote() {
    if (!formKey.currentState!.validate()) {
      return;
    }

    String title = titleController.text;

    String content = contentController.text;
    String image = imageController.text;
    bool isFavorite = isFavorited ? true : false;
    String id = DateTime
        .now()
        .millisecondsSinceEpoch
        .toString();

    final note = Note(id, title, content, isFavorite,image);

    //NoteDatabase.insertNotes(note);

    firestore.collection('name').doc(id).set(note.toMap());

    Navigator.pop(context, note);
  }

  removeFromFavScreen(int index) {
    firestore
        .collection("fav")
        .doc(myFavorite[index].id)
        .delete();
    //NoteDatabase.deleteNote(myFavorite[index].id);
    myFavorite.removeAt(index);
    setState(() {});
  }

  addToFavScreen() {
    if (!formKey.currentState!.validate()) {
      return;
    }

    String title = titleController.text;

    String content = contentController.text;
    String image = imageController.text;
    bool isFavorite = true;
    String id = DateTime
        .now()
        .millisecondsSinceEpoch
        .toString();

    final note = Note(id, title, content, isFavorite,image);

    //NoteDatabase.insertNotes(note);

    firestore.collection('fav').doc(id).set(note.toMap());
  }
}