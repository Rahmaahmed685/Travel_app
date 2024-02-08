import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'note.dart';

class EditNoteScreen extends StatefulWidget {
  const EditNoteScreen({super.key, required this.note});

  final Note note;

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final imageController = TextEditingController();

  final firestore = FirebaseFirestore.instance;

  final formKey = GlobalKey<FormState>();
  bool isFavorited = false;
  List<Note> myFavorite = [];

  int index = 0;
  @override
  void initState() {
    super.initState();
    titleController.text = widget.note.title;
    contentController.text = widget.note.content;
    imageController.text = widget.note.image;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Note"),
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
              SizedBox(height: 10,),
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
                  if (value.length < 5) {
                    return "Title is very small!";
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
                  onPressed: () => updateNote(),
                  child: const Text("Update"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void updateNote() {
    if (!formKey.currentState!.validate()) {
      return;
    }

    String title = titleController.text;
    String content = contentController.text;

    widget.note.title = title;
    widget.note.content = content;

    firestore.collection("name")
        .doc(widget.note.id)
        .update(widget.note.toMap());

    Navigator.pop(context, widget.note);
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
