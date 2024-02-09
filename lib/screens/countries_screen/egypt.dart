import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../shared.dart';
import '../../widgets/app_header_text.dart';
import '../../widgets/app_text.dart';
import '../bar_item_pages/home_screen.dart';
import '../bar_item_pages/secound_page.dart';

class EgyptScreen extends StatefulWidget {
  const EgyptScreen({super.key});

  @override
  State<EgyptScreen> createState() => _EgyptScreenState();
}

class _EgyptScreenState extends State<EgyptScreen> {
  int gottenStars = 3;
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
                    NetworkImage("https://t3.ftcdn.net/jpg/01/01/14/12/360_F_101141241_KuMSNHvZaXQL2yQFWbLQwxMwdUozduzo.jpg"),
                    placeholder: const AssetImage("assets/images/loadingimage.png"),
                    // imageErrorBuilder: (context, error, stackTrace) {
                    //   return Image.asset('assets/images/background.jpg',
                    //       fit: BoxFit.cover);
                    // },
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
                                    AppHeaderText(text: "Egypt"),

                                    IconButton(onPressed: (){}, icon: Icon(Icons.favorite_border))
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
                                SizedBox(height: 7.h,),

                                Text("About :",
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                                SizedBox(height: 5.h,),
                                AppContentText(text: " Egypt is home to some of the world's most iconic ancient landmarks, including the Great Pyramids of Giza which is the only remaining wonder of the ancient world.",
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
                                          child: ExploreItems(
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
  Widget ExploreItems({
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
}

