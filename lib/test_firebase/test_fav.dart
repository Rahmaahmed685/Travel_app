import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/model/place.dart';

import '../shared.dart';

class TFavoriteScreen extends StatefulWidget {
  const TFavoriteScreen({super.key});

  @override
  State<TFavoriteScreen> createState() => _TFavoriteScreenState();
}

class _TFavoriteScreenState extends State<TFavoriteScreen> {
  List<Place> myFavorite = [];
  final firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    checkInternetConnection();
    isLoggedIn();
  }

  void getNotesFromFirestore() {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    firestore
        .collection("fav")
        .where('userId', isEqualTo: userId)
        .get()
        .then((value) {
      myFavorite.clear();
      for (var document in value.docs) {
        final note = Place.fromMap(document.data());
        myFavorite.add(note);
      }
      setState(() {});
    }).catchError((error) {
      print("Erorrrr=> $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite"),
      ),
      body: ListView.builder(
        itemCount: myFavorite.length,
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
          IconButton(onPressed: (){
            firestore
                .collection("fav")
                .doc(myFavorite[index].id)
                .delete();
            //NoteDatabase.deleteNote(myFavorite[index].id);
            myFavorite.removeAt(index);
            setState(() {});
          },
              icon: Icon(Icons.favorite,color: Colors.red,)),

          Padding(
            padding:
            const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
            child: Text(
              myFavorite[index].test,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ),
          Padding(
            padding:
            const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
            child: Text(
              myFavorite[index].title,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void isLoggedIn() async {
    final loggedIn = PreferenceUtils.getBool(PrefKeys.loggedIn);
    print('LoggedIn => $loggedIn');
  }

  void saveLogout() async {
    PreferenceUtils.setBool(PrefKeys.loggedIn, false);
  }

  void checkInternetConnection() async {
   // bool hasConnection = await InternetConnectionChecker().hasConnection;
   //  if (hasConnection) {
   //    print('hasConnection');
      getNotesFromFirestore();
    // } else {
    //   print('Offline');
    //
    // }
  }

}