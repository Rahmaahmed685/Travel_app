
import 'package:flutter/material.dart';
import 'package:travel_app/shared.dart';

class NewsSelectCountryScreen extends StatefulWidget {
  const NewsSelectCountryScreen({super.key});

  @override
  State<NewsSelectCountryScreen> createState() =>
      _NewsSelectCountryScreenState();
}

class _NewsSelectCountryScreenState extends State<NewsSelectCountryScreen> {
  final countries = [
    'us',
    'eg',
    'sa',
    'ae',
    'ch',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text('Select country'),
      ),
      body: ListView.separated(
        itemCount: countries.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () => saveSelectedCountry(countries[index]),
            child: Container(
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(countries[index],style: Theme.of(context).textTheme.titleSmall,),
                 // const Spacer(),
                 // const Icon(Icons.keyboard_arrow_right_rounded),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return
            Padding(
              padding: const EdgeInsets.only(left:70,right: 70),
              child: Container(
              color: PreferenceUtils.getBool(PrefKeys.darkTheme)
                  ? Colors.white
                  : Colors.blue,
              height: 1,
          ),
            );
        },
      ),
    );
  }

  saveSelectedCountry(String selectedCountry) {
    PreferenceUtils.setString(
      PrefKeys.newsCountry,
      selectedCountry,
    );

    Navigator.pop(context);
  }
}