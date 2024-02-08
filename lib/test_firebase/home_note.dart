import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/test_firebase/note.dart';

import '../model/place.dart';
import '../screens/manager/login/login.dart';
import '../shared.dart';
import 'add_note.dart';
import 'edit.dart';
import 'favorite_screen.dart';

class THomeScreen extends StatefulWidget {
  const THomeScreen({super.key});

  @override
  State<THomeScreen> createState() => _THomeScreenState();
}

class _THomeScreenState extends State<THomeScreen> {
  List<Note> myNotes = [];
  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    getNotes();
    getLoggedIn();
  }

  void getNotes() {
    firestore
        .collection("name")
        .where('userId', isEqualTo: auth.currentUser!.uid)
        .get()
        .then((value) {
      myNotes.clear();
      for (var doc in value.docs) {
        final note = Note.fromMap(doc.data());
        myNotes.add(note);
      }
      setState(() {});
    }).catchError((error) {
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoriteScreen(),
                ),
              );
            },
            icon: const Icon(Icons.favorite),
          ),
          IconButton(
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const ProfileScreen(),
              //   ),
              // );
            },
            icon: const Icon(Icons.person),
          ),
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              saveLogout();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => openAddNoteScreen(),
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: myNotes.length,
        itemBuilder: (context, index) {
          print(index);
          return buildNoteItem(index);
        },
      ),
    );
  }

  Widget buildNoteItem(int index) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.grey[300], borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            myNotes[index].image,
            width:double.infinity,
            height: 150,
            fit: BoxFit.fill,),
          Padding(
            padding:
            const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
            child: Text(
              myNotes[index].title,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
            child: Text(
              myNotes[index].content,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    firestore
                        .collection("notes")
                        .doc(myNotes[index].id)
                        .delete();
                    myNotes.removeAt(index);
                    setState(() {});
                  },
                  icon: const Icon(Icons.delete),
                  label: const Text("Delete"),
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    backgroundColor: Colors.red,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => editNote(index),
                  icon: const Icon(
                    Icons.edit,
                  ),
                  label: const Text("Edit"),
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void openAddNoteScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TestAddNoteScreen(),
      ),
    ).then((value) => getNotes());
  }

  void addNewNote(Note value) {
    myNotes.add(value);
    setState(() {});
  }

  void editNote(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditNoteScreen(
          note: myNotes[index],
        ),
      ),
    ).then((value) => updateCurrentNote(index, value));
  }

  updateCurrentNote(int index, Note value) {
    myNotes[index] = value;
    setState(() {});
  }

  void getLoggedIn() async {
    final loggedIn = PreferenceUtils.getBool(PrefKeys.loggedIn);
    print('loggedIn => $loggedIn');
  }

  Future<void> saveLogout() async {
    PreferenceUtils.setBool(PrefKeys.loggedIn, false);
  }
}