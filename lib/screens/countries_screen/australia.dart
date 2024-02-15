import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:travel_app/model/shared.dart';
import 'package:travel_app/model/place.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../model/app_header_text.dart';
import '../../model/app_text.dart';

class AustraliaScreen extends StatefulWidget {
  const AustraliaScreen({super.key});

  @override
  State<AustraliaScreen> createState() => _AustraliaScreenState();
}

class _AustraliaScreenState extends State<AustraliaScreen> {
  final firestore = FirebaseFirestore.instance;

  List<Place> myCountries = [];

  @override
  void initState() {
    super.initState();
    getPlacesFromFirestore();
    //isLoggedIn();
  }

  void getPlacesFromFirestore() {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    firestore
        .collection("countries")
        .where('userId', isEqualTo: userId)
        .get()
        .then((value) {
      myCountries.clear();
      for (var document in value.docs) {
        // print(document.data());
        final note = Place.fromMap(document.data());
        myCountries.add(note);
      }
      setState(() {});
    }).catchError((error) {
      print("Erorrrr=> $error");
    });
  }

  int index = 0;
  bool isFavorited = false;
  List title =[
    "Sydney",
    "Great Barrier Reef",
    "Tasmania",
    "Darwin",

  ];
  List subImage =[
    "https://media.lmpm.website/uploads/sites/4/2022/10/Sydney-Harbour-Photo-1.jpg",
    "https://www.mediastorehouse.com.au/p/623/sydney-skyline-night-9873203.jpg.webp",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTjUJXRvYH9pHAal28dRRvZTVz1TQisfwT6JQ&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTshmtdYdzzNPYC3gvsQseoK1WSpV-VhI04tQ&usqp=CAU",
  ];
  List url = [
    'https://www.holidify.com/places/sydney/sightseeing-and-things-to-do.html',
    'https://www.holidify.com/places/great-barrier-reef/sightseeing-and-things-to-do.html',
    'https://www.holidify.com/places/tasmania/sightseeing-and-things-to-do.html',
    'https://www.holidify.com/places/darwin/sightseeing-and-things-to-do.html'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
    slivers: [
    SliverAppBar(
      floating: false,
      pinned: false,
      expandedHeight: 400,
      flexibleSpace: Stack(
        children: [
           Positioned.fill(
            child: FadeInImage(
              image:
                  NetworkImage(myCountries[0].image),
                  placeholder: AssetImage("assets/images/loadingimage.png"),
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            child: Container(
              height: 33,
              decoration: BoxDecoration(
                color: PreferenceUtils.getBool(PrefKeys.darkTheme)
                    ? Colors.black
                    : Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(40),
                ),
              ),
            ),
            bottom: -7,
            left: 0,
            right: 0,
          )
        ],
      ),
    ),
      SliverToBoxAdapter(
          child: Container(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      height: 1000,
                      decoration: BoxDecoration(
                        color:  PreferenceUtils.getBool(PrefKeys.darkTheme)
                            ? Colors.black
                            : Colors.white,

                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppHeaderText(text:myCountries[0].title),

                              IconButton(
                                onPressed: () {
                                 addToFavScreen();
                                  setState(() => isFavorited = !isFavorited);
                                },
                                icon: isFavorited
                                    ? Icon(Icons.favorite, color: Colors.red,)
                                    : Icon(Icons.favorite_border),
                              ),
                            ],
                          ),
                          SizedBox(height: 7,),
                          Row(children: [
                            Icon(Icons.location_on,
                              color: PreferenceUtils.getBool(PrefKeys.darkTheme)
                                ? Colors.white
                                : Colors.blue,
                              size: 20,),
                            AppContentText(text: myCountries[0].content,)
                          ],),
                          SizedBox(height: 7,),

                           Text("About :",
                             style: Theme.of(context).textTheme.titleMedium,
                           ),
                           SizedBox(height: 5,),
                            AppContentText(text: "A land of breathtaking contrasts, Australia beckons with its unrivaled natural wonders, vibrant cities, and diverse cultural tapestry. ",
                               ),
                      SizedBox(height: 20,),
                            Text("Best Place To Visit",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),

                            AppContentText(text: "Summer time, you should try this place",
                               ),

                            SizedBox(
                              height: 270,
                              child:ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: title.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding:EdgeInsets.only(right: 10,bottom: 20),
                                      child: SubItems(
                                        title: title[index],
                                        color: Colors.purple.withOpacity(0.5),
                                        image: subImage[index],
                                        onTab: () {
                                          Navigator.push(
                                            context,
                                            PageTransition(
                                                type: PageTransitionType.bottomToTop,
                                                child: url[index],
                                                // inheritTheme: true,
                                                // ctx: context
                                                duration: Duration(milliseconds: 500)
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  }),
                            ),


                          ],),
                      ),
                    ),
                  ])
          )
      )

    ],
    ),

    );
  }
  Widget SubItems({
    required String title,
    required Color color,
    required String image,
    required GestureTapCallback onTab,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 20,bottom: 20),
      child: GestureDetector(
        onTap: onTab,
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomLeft,
              children:[ Container(
                height: 200,
                width: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    color: color
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(image,fit: BoxFit.fill,)),
              ),
            Padding(
              padding: const EdgeInsets.all(10),
              child:  InkWell(
                onTap: ()=> launch(url[index]),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ],
        ),
      ]
      ),
    )
    );
  }

  removeFromFavScreen(int index) {
    firestore.collection("fav")
        .doc(myCountries[index].id)
        .delete();
    myCountries.removeAt(index);
    setState(() {});
  }

  addToFavScreen() {
    String title = myCountries[0].title;

    String content = myCountries[0].content;
    String image = myCountries[0].image;
    bool isFavorite = true;
    String id = DateTime
        .now()
        .millisecondsSinceEpoch
        .toString();

    final note = Place(id, title, content, isFavorite,image);

    //NoteDatabase.insertNotes(note);

    firestore.collection('fav').doc(id).set(note.toMap());
  }
}

