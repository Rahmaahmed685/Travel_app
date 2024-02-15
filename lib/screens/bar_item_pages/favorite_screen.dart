import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/model/place.dart';

import '../../generated/l10n.dart';
import '../../model/rating.dart';
import '../../model/shared.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<Place> myFavorite = [];
  final firestore = FirebaseFirestore.instance;
  double rating = 3.5;

  @override
  void initState() {
    super.initState();
    getNotesFromFirestore();
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
       // print(document.data());
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
        elevation: 1,
        title:  Text(S().Favorite),
      ),
      body:
      ListView.builder(
        itemCount: myFavorite.length,
        itemBuilder: (context, index) {
          print(index);
          return buildNoteItem(index);
        },
      ),
    );
  }

  Widget buildNoteItem(int index) {
    return
      Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
              color: PreferenceUtils.getBool(PrefKeys.darkTheme)
             ?  Color(0XFFd8f3dc).withOpacity(0.6)
            :  Colors.grey[200],

              borderRadius: BorderRadius.circular(15)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                Stack(
                    alignment: Alignment.topRight,
                    children:[
                      SizedBox(
                        width: double.infinity,
                        height: 200,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(myFavorite[index].image,
                              fit: BoxFit.fill,)),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                            child:
                            InkWell(
                              onTap: (){
                                  firestore
                                      .collection("fav")
                                      .doc(myFavorite[index].id)
                                      .delete();
                                  // NoteDatabase.deleteNote(myFavorite[index].id);
                                  myFavorite.removeAt(index);
                                  setState(() {});
                                },
                              child: Icon(Icons.favorite,color: Colors.red,)
                        ),
                      ),
                      ),
                    ]
                ),

              ),


              SizedBox(height: 10,),
              Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text(
                  //"title",
                   myFavorite[index].title,
                  style: Theme.of(context).textTheme.titleMedium

                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15),
                child: Row(
                  children: [
                    Icon(Icons.location_on),
                    Text(
                      //"address",
                      myFavorite[index].content,
                      style: Theme.of(context).textTheme.titleSmall

                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15,bottom: 15),
                child: StarRating(
                  rating: rating,
                  onRatingChanged: (rating) => setState(() => this.rating = rating),
                  color: Colors.yellow,
                ),
              ),
            ],
          ),
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
}
//         Container(
//           width: double.infinity,
//          height: 200,
//           decoration: BoxDecoration(
//               color: Colors.grey[300], borderRadius: BorderRadius.circular(15)),
//          // child:
//           // Column(
//           //   crossAxisAlignment: CrossAxisAlignment.start,
//           //   children: [
//           //     IconButton(onPressed: (){
//                 // firestore
//                 //     .collection("fav")
//                 //     .doc(myFavorite[index].id)
//                 //     .delete();
//                 // // NoteDatabase.deleteNote(myFavorite[index].id);
//                 // myFavorite.removeAt(index);
//                 // setState(() {});
//               // },
//               //     icon: Icon(Icons.favorite,color: Colors.red,)),
//                 child: ClipRRect(
// borderRadius: BorderRadius.circular(10),
// child: Image.asset("assets/images/mountain.png",fit: BoxFit.fill,)),
//
//
//                 // Text(
//                 //   "title",
//                 //  // myFavorite[index].test,
//                 //   style: const TextStyle(
//                 //     color: Colors.black,
//                 //     fontWeight: FontWeight.bold,
//                 //     fontSize: 22,
//                 //   ),
//                 // ),
//
//               // Padding(
//               //   padding:
//               //   const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
//               //   child: Text(
//               //     "address",
//               //     //myFavorite[index].title,
//               //     style: const TextStyle(
//               //       color: Colors.black,
//               //       fontWeight: FontWeight.bold,
//               //       fontSize: 22,
//               //     ),
//               //   ),
//               // ),
//              // ),
//          //   ],
//         //  ),
//         ),