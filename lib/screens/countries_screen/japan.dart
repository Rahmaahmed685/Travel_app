import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:travel_app/screens/bar_item_pages/home_screen.dart';
import 'package:travel_app/model/shared.dart';
import '../../model/app_header_text.dart';
import '../../model/app_text.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../model/place.dart';
import '../bar_item_pages/secound_page.dart';

class JapanScreen extends StatefulWidget {
  const JapanScreen({super.key});

  @override
  State<JapanScreen> createState() => _JapanScreenState();
}

class _JapanScreenState extends State<JapanScreen> {
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
  List title =[
    "Tokyo",
    "Osaka",
    "Kyoto",
    "Nagasaki",

  ];
  List subImages =[
    "https://www.state.gov/wp-content/uploads/2019/04/Japan-2107x1406.jpg",
    "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/26/97/39/7f/caption.jpg?w=1200&h=-1&s=1&cx=1920&cy=1080&chk=v1_f31158e4bb953d28a308",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ0WXcoNz2lt0d2F574gyg31__nSoVScFFxVQ&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSp8SGvh1Oj81Wq-YuwRKY48dFMML_G81rgWw&usqp=CAU",
  ];
  List url = [
    'https://www.holidify.com/places/tokyo/sightseeing-and-things-to-do.html',
        'https://www.holidify.com/places/osaka/sightseeing-and-things-to-do.html',
    'https://www.holidify.com/places/kyoto/sightseeing-and-things-to-do.html',
        'https://www.holidify.com/places/nagasaki/',
  ];
  bool isFavorited = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            //backgroundColor: Colors.white,
            floating: false,
            pinned: false,
            expandedHeight: 400,
            flexibleSpace: Stack(
              children: [
                 Positioned.fill(
                  child: FadeInImage(
                    image:
                    NetworkImage(myCountries[4].image),
                    placeholder: const AssetImage("assets/images/loadingimage.png"),
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
                                    AppHeaderText(text: myCountries[4].title),

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
                                  AppContentText(text: myCountries[4].content,)
                                ],),
                                SizedBox(height: 7,),

                                Text("About :",
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                                SizedBox(height: 5,),
                                AppContentText(text: "Japan, located in Eastern Asia, is a sovereign nation. It is well known for its bustling cities, imperial palaces, national parks and lots of beautifully constructed temples.",
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
                                            image: subImages[index],
                                            index: index,
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
    required int index,
  }) {
    return Padding(
        padding: const EdgeInsets.only(top: 20,bottom: 20),
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
                    child:
                    InkWell(
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

                  // Text("$title",style: TextStyle(color: Colors.white),),

                ],
              ),
            ]
        )
    );
  }
  addToFavScreen() {
    String title = myCountries[4].title;

    String content = myCountries[4].content;
    String image = myCountries[4].image;
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
