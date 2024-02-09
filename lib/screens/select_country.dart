
import 'package:flutter/material.dart';
import 'package:travel_app/shared.dart';

class SelectCountryScreen extends StatefulWidget {
  const SelectCountryScreen({super.key});

  @override
  State<SelectCountryScreen> createState() =>
      _SelectCountryScreenState();
}

class _SelectCountryScreenState extends State<SelectCountryScreen> {
  final countries = [
    'US',
    'EG',
    'TU',
    'FR',
    'DE',
  ];

  final images = [
    "https://cdn.britannica.com/33/4833-004-828A9A84/Flag-United-States-of-America.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/f/fe/Flag_of_Egypt.svg/255px-Flag_of_Egypt.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b4/Flag_of_Turkey.svg/1200px-Flag_of_Turkey.svg.png",
    "https://cdn.britannica.com/82/682-004-F0B47FCB/Flag-France.jpg",
    "https://upload.wikimedia.org/wikipedia/en/thumb/b/ba/Flag_of_Germany.svg/1200px-Flag_of_Germany.svg.png",

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
                children: [
                  Text(countries[index],style: Theme.of(context).textTheme.titleSmall,),
                  Spacer(),
                  SizedBox(
                    width: 25,
                    height: 25,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(images[index], fit: BoxFit.fill)),
                  ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return
            Padding(
              padding: const EdgeInsets.only(left:10,right: 10),
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