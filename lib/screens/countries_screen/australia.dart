import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:travel_app/model/place.dart';
import 'package:travel_app/screens/bar_item_pages/home_screen.dart';
import 'package:travel_app/shared.dart';
import 'package:travel_app/widgets/app_header_text.dart';
import 'package:travel_app/widgets/app_text.dart';
import '../bar_item_pages/secound_page.dart';

class AustraliaScreen extends StatefulWidget {
  const AustraliaScreen({super.key});

  @override
  State<AustraliaScreen> createState() => _AustraliaScreenState();
}

class _AustraliaScreenState extends State<AustraliaScreen> {
  List<Place> myFavorite = [];

  int gottenStars = 3;
  int index = 0;
  bool isFavorited = false;
  List title =[
    "Kayaking",
    "Snorkeling",
    "Ballooning",
    "Hiking",

  ];
  List exploreImage =[
    "assets/images/welcome_one.png",
    "assets/images/welcome_three.png",
    "assets/images/welcome_two.png",
    "assets/images/welcome_one.png",
  ];
  List screens = [
    HomeScreen(),
    SecoundPage(),
    SizedBox(),
    SizedBox(),
  ];
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final testController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  final firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
    slivers: [
    SliverAppBar(
    //backgroundColor: Colors.white,
      floating: false,
      pinned: false,
      expandedHeight: 400.h,
      flexibleSpace: Stack(
        children: [
          const Positioned.fill(
            child: FadeInImage(
              image:
                  NetworkImage("https://img.freepik.com/free-photo/aerial-view-tokyo-cityscape-with-fuji-mountain-japan_335224-148.jpg"),
                  placeholder: const AssetImage("assets/images/loadingimage.png"),
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            child: Container(
              height: 33.h,
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
                      height: 1000.h,
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
                              AppHeaderText(text: "Australia"),

                              IconButton(
                                onPressed: () {
                                  isFavorited
                                      ? removeFromFavScreen(index)
                                      :addToFavScreen();
                                  setState(() => isFavorited = !isFavorited);
                                },
                                icon: isFavorited
                                    ? Icon(Icons.favorite, color: Colors.red,)
                                    : Icon(Icons.favorite_border),
                              ),
                            ],
                          ),
                          SizedBox(height: 7.h,),
                          Row(children: [
                            Icon(Icons.location_on,
                              color: PreferenceUtils.getBool(PrefKeys.darkTheme)
                                ? Colors.white
                                : Colors.blue,
                              size: 20,),
                            AppContentText(text: "USA, California",)
                          ],),
                          SizedBox(height: 7.h,),

                           Text("About :",
                             style: Theme.of(context).textTheme.titleMedium,
                           ),
                           SizedBox(height: 5.h,),
                            AppContentText(text: "A land of breathtaking contrasts, Australia beckons with its unrivaled natural wonders, vibrant cities, and diverse cultural tapestry. ",
                               ),
                      SizedBox(height: 20.h,),
                            Text("Best Place To Visit",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),

                            AppContentText(text: "Summer time, you should try this place",
                               ),

                            SizedBox(
                              height: 270.h,
                              child:ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: title.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding:EdgeInsets.only(right: 10,bottom: 20),
                                      child: SubItems(
                                        title: title[index],
                                        color: Colors.purple.withOpacity(0.5),
                                        image: exploreImage[index],
                                        onTab: () {
                                          Navigator.push(
                                            context,
                                            PageTransition(
                                                type: PageTransitionType.bottomToTop,
                                                child: screens[index],
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
                height: 200.h,
                width: 150.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    color: color
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(image,fit: BoxFit.fill,)),
              ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text("$title",style: TextStyle(color: Colors.white),),
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
        .doc(myFavorite[index].id)
        .delete();
    myFavorite.removeAt(index);
    setState(() {});
  }

  addToFavScreen() {
    if (!formKey.currentState!.validate()) {
      return;
    }

    String title = titleController.text;

    String address = contentController.text;
    String test = testController.text;
    bool isFavorite = true;
    String id = DateTime.now().millisecondsSinceEpoch.toString();

    final note = Place(id, title, address,test,isFavorite);

    //NoteDatabase.insertNotes(note);

    firestore.collection('fav').doc(id).set(note.toMap());
  }
}

