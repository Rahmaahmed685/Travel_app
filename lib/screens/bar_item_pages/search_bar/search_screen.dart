import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../generated/l10n.dart';
import '../screens/countries_screen/australia.dart';
import '../screens/countries_screen/egypt.dart';
import '../screens/countries_screen/france_screen.dart';
import '../screens/countries_screen/italy_screen.dart';
import '../screens/countries_screen/japan.dart';
import '../screens/countries_screen/malaysia.dart';
import '../screens/countries_screen/maldives.dart';
import '../screens/countries_screen/new_zealand.dart';
import '../screens/countries_screen/singapora.dart';
import '../screens/countries_screen/thailand.dart';
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
        elevation: 1,
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
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
    body: Center(child: Lottie.asset("assets/animations/search.json")),
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
          ListTile(
            title: Text(result),
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
      itemCount:  query.isEmpty?
          1:
      matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return
          query.isEmpty?
           Lottie.asset("assets/animations/search.json")
              :
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

