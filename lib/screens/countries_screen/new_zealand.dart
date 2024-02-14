import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:travel_app/screens/bar_item_pages/home_screen.dart';
import 'package:travel_app/model/shared.dart';
import '../../model/app_header_text.dart';
import '../../model/app_text.dart';
import 'package:url_launcher/url_launcher.dart';
import '../bar_item_pages/secound_page.dart';

class NewZealandScreen extends StatefulWidget {
  const NewZealandScreen({super.key});

  @override
  State<NewZealandScreen> createState() => _NewZealandScreenState();
}

class _NewZealandScreenState extends State<NewZealandScreen> {
  List title =[
    "Auckland",
    "Napier",
    "Rotorua",
    "Queenstown",

  ];
  List exploreImage =[
    "https://cdn.britannica.com/68/179868-138-F4FC616A/Overview-discussion-Southern-Alps-warming-New-Zealand.jpg?w=800&h=450&c=crop",
    "https://www.newzealand.com/assets/Job-2189_TNZ_Autumn_R52_5812_Final_HR__aWxvdmVrZWxseQo_FocalPointCropWzQzMCw2MzAsNDQsNDUsNzUsImpwZyIsNjUsMi41XQ.jpg",
    "https://newzealandtrails.com/assets/Uploads/_resampled/FillWyIxMjAwIiwiNjMwIl0/Our-like-minded-guests-enjoying-the-Routeburn-Track2.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ1XThCTen35tiCfYWvbKZd1m_hsN1T9ntOjw&usqp=CAU",
  ];
  List url = [
    'https://www.holidify.com/places/auckland/sightseeing-and-things-to-do.html',
    'https://www.holidify.com/places/napier/sightseeing-and-things-to-do.html',
    'https://www.holidify.com/places/rotorua/sightseeing-and-things-to-do.html',
    'https://www.holidify.com/places/queenstown/sightseeing-and-things-to-do.html',
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
                const Positioned.fill(
                  child: FadeInImage(
                    image:
                    NetworkImage("https://cdn.britannica.com/68/179868-138-F4FC616A/Overview-discussion-Southern-Alps-warming-New-Zealand.jpg?w=800&h=450&c=crop"),
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
                                    AppHeaderText(text: "NewZealand"),

                                    IconButton(
                                      onPressed: () {
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
                                  AppContentText(text: "USA, California",)
                                ],),
                                SizedBox(height: 7,),

                                Text("About :",
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                                SizedBox(height: 5,),
                                AppContentText(text: "New Zealand lies to the southwest of the Pacific Ocean and promises breathtaking landscapes adorned with picturesque coastlines and the mightiest mountains.",
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
                                            image: exploreImage[index],
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
                ],
              ),
            ]
        )
    );
  }
}

