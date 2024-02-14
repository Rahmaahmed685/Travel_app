import 'package:flutter/material.dart';
import 'package:travel_app/model/shared.dart';
import '../../model/app_header_text.dart';
import '../../model/app_text.dart';
import 'package:url_launcher/url_launcher.dart';

class ThailandScreen extends StatefulWidget {
  const ThailandScreen({super.key});

  @override
  State<ThailandScreen> createState() => _ThailandScreenState();
}

class _ThailandScreenState extends State<ThailandScreen> {
  List title =[
    "Phuket",
    "Phi Phi Islands",
    "Krabi",
    "Bangkok",
  ];
  List exploreImage =[
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTpGSmBw9_HlDsiyoQtHztSeYljBwu2Q1gCYw&usqp=CAU",
    "https://www.renown-travel.com/images/phi-phi-islands-l.jpg",
    "https://cdn2.veltra.com/ptr/20180627100153_281505209_13137_0.jpg",
    "https://www.intrepidtravel.com/v3/assets/blt0de87ff52d9c34a8/bltf3db7c6c40fc3eae/63c8b6b5f6810d6359582f3f/TTZT_thailand_ao-nang_beach-long-boat.jpg",
  ];

 List url = [
   'https://www.holidify.com/places/phuket/sightseeing-and-things-to-do.html',
   'https://www.holidify.com/places/phi-phi-islands/sightseeing-and-things-to-do.html',
   'https://www.holidify.com/places/krabi/sightseeing-and-things-to-do.html',
   'https://www.holidify.com/places/bangkok/sightseeing-and-things-to-do.html',
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
                    NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTHC6qC77h6g01dADPXS7ctJ67FOTWk4DVS9A&usqp=CAU"),
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
                                    AppHeaderText(text: "Thailand"),

                                    IconButton(onPressed: (){
                                      setState(() => isFavorited = !isFavorited);
                                    },
                                        icon:
                                        isFavorited
                                            ? Icon(Icons.favorite,color: Colors.red,)
                                            : Icon(Icons.favorite_border)
                                    )
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
                                AppContentText(text: "Thailand is a Southeast Asian country and one of Asia’s most popular tourist destinations, with stunning beaches, vibrant nightlife, and a backpacker-friendly atmosphere. Sharing borders with Myanmar, Laos, Cambodia, and Malaysia, it is one of the top countries for exploring this region.",
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

