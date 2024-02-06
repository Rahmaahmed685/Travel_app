import 'package:flutter/material.dart';
import 'package:flutter_page_transition_plus/flutter_page_transition_plus.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:travel_app/screens/countries_screen/france_screen.dart';
import 'package:travel_app/screens/countries_screen/italy_screen.dart';
import 'package:travel_app/screens/countries_screen/japan.dart';
import 'package:travel_app/screens/countries_screen/malaysia.dart';
import 'package:travel_app/screens/countries_screen/maldives.dart';
import 'package:travel_app/screens/countries_screen/new_zealand.dart';
import 'package:travel_app/screens/countries_screen/singapora.dart';
import 'package:travel_app/screens/countries_screen/thailand.dart';
import 'package:travel_app/screens/countries_screen/australia.dart';
import 'package:travel_app/widgets/app_header_text.dart';

import '../countries_screen/egypt.dart';
import '../setting.dart';
import '../../shared.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  List tabBarImages = [
    "assets/images/welcome_two.png",
    "assets/images/welcome_two.png",
    "assets/images/welcome_two.png",
  ];
  List title =[
    "Australia",
    "Egypt",
    "France",
    "Italy",
    "Japan",
    "Malaysia",
    "NewZealand",
    "Singapore",
    "Maldives",
    "Thailand",

  ];
  List exploreImage =[
    "assets/images/welcome_one.png",
    "assets/images/welcome_three.png",
    "assets/images/welcome_two.png",
    "assets/images/welcome_one.png",
    "assets/images/welcome_one.png",
    "assets/images/welcome_three.png",
    "assets/images/welcome_two.png",
    "assets/images/welcome_one.png",
    "assets/images/welcome_one.png",
    "assets/images/welcome_three.png",
  ];
  List screens = [
    AustraliaScreen(),
    EgyptScreen(),
    FranceScreen(),
    ItalyScreen(),
    JapanScreen(),
    MalaysiaScreen(),
    NewZealandScreen(),
    SingaporeScreen(),
    MaldivesScreen(),
    ThailandScreen()
  ];
  double scaleFactor = 1;
  bool isVisible = true;
  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 3, vsync: this);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 50,
        actions: [
          Padding(
              padding: const EdgeInsets.all(10),
              child: IconButton(
                  icon: Icon(
                    Icons.settings,
                    size: 30,),
                  onPressed: () {
                    Navigator.push(
                      context, (MaterialPageRoute(
                        builder: (context) => NewsSettingsScreen()
                    )
                    ),
                    );
                  })
          ),
        ],
      ),
      body: ListView(
        children: [
          Lottie.asset('assets/animations/logo.json'),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AppHeaderText(text: "Discover", color: Colors.black),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Container(
              child: TabBar(
                  labelPadding: EdgeInsets.only(left: 0, right: 20),
                  labelColor:  PreferenceUtils.getBool(PrefKeys.darkTheme)? Colors.white: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  isScrollable: true,
                  dividerColor: Colors.transparent,
                  indicator:
                  CircleTabIndicator(color: Colors.deepPurple, radius: 4),
                  //indicatorSize: TabBarIndicatorSize.label,
                  controller: _tabController,
                  tabs: [
                    Tab(
                      text: "Places",
                    ),
                    Tab(
                      text: "Hotels",
                    ),
                    Tab(
                      text: "emotions",
                    ),
                  ]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Container(
              height: 250,
              width: double.maxFinite,
              child: TabBarView(
                  controller: _tabController,
                  children: [
                    ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: EdgeInsets.only(right: 15, top: 10),
                          width: 200,
                          height: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            //color: Colors.white,
                            image: DecorationImage(
                                image: AssetImage(
                                    tabBarImages[index]
                                ),
                                fit: BoxFit.cover),
                          ),
                        );
                      },
                    ),
                    Text("secound"),
                    Text("third"),
                  ]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, right: 10,left: 8),
            child: Row(children: [
              Text("Explore More", style: Theme.of(context).textTheme.titleMedium,),



              Spacer(),
              Text("See all", style: Theme.of(context).textTheme.titleSmall, ),
            ],),
          ),
          SizedBox(
            height: 120,
            child:ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: title.length,
                itemBuilder: (context, index) {
                  return ExploreItems(
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
                  );
                }),
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
      padding: const EdgeInsets.only(left: 20,top: 20,bottom: 20,),
      child: GestureDetector(
        onTap: onTab,
        child: Column(
          children: [
            Container(
              height: 50,
              width: 50,
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
            SizedBox(height: 10,),
            Text("$title"),
          ],
        ),
      ),
    );
  }
}

class CircleTabIndicator extends Decoration {
  final Color color;
  double radius;

  CircleTabIndicator({required this.color, required this.radius});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    // TODO: implement createBoxPainter
    return _CirclePainter(color: color, radius: radius);
  }
}

class _CirclePainter extends BoxPainter {
  final Color color;
  double radius;

  _CirclePainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    Paint _paint = Paint();
    _paint.color = color;
    _paint.isAntiAlias = true;
    final Offset circleOffset = Offset(
        configuration.size!.width / 2 - radius / 2,
        configuration.size!.height - radius);
    canvas.drawCircle(offset + circleOffset, radius, _paint);
    // TODO: implement paint
  }
}
