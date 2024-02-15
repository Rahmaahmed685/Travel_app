import 'package:flutter/material.dart';
import 'package:travel_app/model/shared.dart';
import '../../model/app_header_text.dart';
import '../../model/app_text.dart';
import 'package:url_launcher/url_launcher.dart';


class SingaporeScreen extends StatefulWidget {
  const SingaporeScreen({super.key});

  @override
  State<SingaporeScreen> createState() => _SingaporeScreenState();
}

class _SingaporeScreenState extends State<SingaporeScreen> {
  List title =[
    "Gardens",
    "Sentosa",
    "Universal Studios",
    "Clarke Quay",
  ];
  List exploreImage =[
    "https://media.cnn.com/api/v1/images/stellar/prod/220905203459-05-old-sentosa-island.jpg?c=original&q=h_618,c_fill",
    "https://a.cdn-hotels.com/gdcs/production187/d438/72aa3862-1a1d-4005-a030-a331431c8b4f.jpg?impolicy=fcrop&w=800&h=533&q=medium",
    "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/15/1a/9e/23/img-20181020-113259-largejpg.jpg?w=600&h=400&s=1",
    "https://www.introducingsingapore.com/f/singapur/singapur/guia/isla-sentosa-m.jpg",
  ];
  List url = [
    'https://www.holidify.com/places/singapore/gardens-by-the-bay-sightseeing-11503.html',
        'https://www.holidify.com/places/singapore/sentosa-island-places-to-visit-area.html',
    'https://www.holidify.com/places/singapore/universal-studios-singapore-sightseeing-121008.html',
        'https://www.holidify.com/places/singapore/clarke-quay-sightseeing-11513.html'
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
                    NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT18sKlmSZWJEXgX-KZCc5S3AnqgMz0W9CjHQ&usqp=CAU"),
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
                                    AppHeaderText(text: "Singapore"),

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
                                AppContentText(text: "Best described as a microcosm of modern Asia, Singapore is a melting pot of culture and history, and an extravaganza of culinary delights. Officially known as the Republic of Singapore, it is both a city and a country located in Southeast Asia.",
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

                  // Text("$title",style: TextStyle(color: Colors.white),),

                ],
              ),
            ]
        )
    );
  }
}
