import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../generated/l10n.dart';
import '../../countries_screen/australia.dart';
import '../../countries_screen/egypt.dart';
import '../../countries_screen/france_screen.dart';
import '../../countries_screen/italy_screen.dart';
import '../../countries_screen/japan.dart';
import '../../countries_screen/malaysia.dart';
import '../../countries_screen/maldives.dart';
import '../../countries_screen/new_zealand.dart';
import '../../countries_screen/singapora.dart';
import '../../countries_screen/thailand.dart';


class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0XFF829dba),
        elevation: 0,
        title: InkWell(
          onTap: (){
            showSearch(
                context: context,
                // delegate to customize the search bar
                delegate: CustomSearchDelegate()
            );
          },
          child: Text(
            S().SearchHere,
            style: TextStyle(color: Colors.white),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
            },
            icon: const Icon(Icons.search,color: Colors.white,),
          )
        ],
      ),
    body: Center(child: Container(
    width: double.maxFinite,
    height: double.maxFinite,
    decoration: BoxDecoration(
    image: DecorationImage(
    image: AssetImage("assets/images/search.png"),
    fit: BoxFit.fill
    ),
    ),),
    )
    );
  }
}
class CustomSearchDelegate extends SearchDelegate {
// Demo list to show querying
  List screens = [
    AustraliaScreen(),
    FranceScreen(),
    ItalyScreen(),
    JapanScreen(),
    MalaysiaScreen(),
    NewZealandScreen(),
    SingaporeScreen(),
    MaldivesScreen(),
    ThailandScreen(),
    EgyptScreen(),
  ];

  List<String> searchTerms = [
    "Australia",
    "France",
    "Italy",
    "Japan",
    "Malaysia",
    "NewZealand",
    "Singapore",
    "Maldives",
    "Thailand",
    "Egypt",
  ];
// first overwrite to
// clear the search text
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

// second overwrite to pop out of search menu
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

// third overwrite to show query result
  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return
          ListView.builder(
            itemCount: matchQuery.length,
            itemBuilder: (context, index) {
              var result = matchQuery[index];
              return
                ListTile(
                  title: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>
                        screens[index]
                        ));
                      },
                      child: Text(result)),
                );
            },
          );
      },
    );
  }

// last overwrite to show the
// querying process at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return
          ListTile(
            title: InkWell(
               onTap: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>
                 screens[index]
                 ));
               },
                child: Text(result)),
          );
      },
    );
  }
}

