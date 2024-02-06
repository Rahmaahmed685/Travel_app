import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/screens/bar_item_pages/home_screen.dart';
import 'package:travel_app/screens/bar_item_pages/secound_page.dart';
import 'package:travel_app/search_bar/search_screen.dart';

import '../../shared.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final label = [
    "Home",
    "Top",
    "Search",
    "Profile"
  ];
  List screens = [
    HomeScreen(),
    SecoundPage(),
    SearchScreen(),
    SizedBox(),
  ];
  final items = <Widget> [
    Icon(Icons.apps,),
    Icon(Icons.bar_chart_sharp,),
    Icon(Icons.search_rounded,),
    Icon(Icons.perm_identity,),
  ];
  int currentIndex=0;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: SafeArea(
        top: false,
        child: Scaffold(
          bottomNavigationBar: Theme(
            data:Theme.of(context).copyWith(
              iconTheme: IconThemeData(color:  PreferenceUtils.getBool(PrefKeys.darkTheme)? Colors.black87: Colors.white,)
            ) ,
            child: CurvedNavigationBar(
              animationCurve: Curves.easeInOut,
              animationDuration: Duration(milliseconds: 300),
              color:  PreferenceUtils.getBool(PrefKeys.darkTheme)? Colors.white: Colors.blue,
              backgroundColor:  PreferenceUtils.getBool(PrefKeys.darkTheme)? Colors.black: Colors.transparent,
              height: 60,
                index: currentIndex,
                items: items,
                onTap: (value){
              currentIndex = value;
              setState(() {
              });
            },
            ),
          ) ,
          body: screens[currentIndex],
        ),
      ),
    );
  }

}
