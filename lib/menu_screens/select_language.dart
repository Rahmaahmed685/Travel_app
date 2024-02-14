import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../screens/manager/app_manager/app_cubit.dart';
import '../model/shared.dart';

class SelectLanguageScreen extends StatefulWidget {
  const SelectLanguageScreen({super.key});

  @override
  State<SelectLanguageScreen> createState() =>
      _SelectLanguageScreenState();
}

class _SelectLanguageScreenState extends State<SelectLanguageScreen> {
  final languages = [
    'English',
    'العربيه',
    'Deutsch',
    'Turkce',
    'Francais',
    'स्वागतम्।',
    'Afrikaans',
    'Filipino',
    'Italiano',
    'Melayu',
  ];
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text('Select Language'),
      ),
      body: ListView.separated(
        itemCount: languages.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () => saveSelectedCountry(languages[index]),
            child: Container(
              padding: const EdgeInsets.all(15),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(languages[index],style: Theme.of(context).textTheme.titleSmall,),
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
      PrefKeys.language,
      selectedCountry,
    );

    Navigator.pop(context);
  }

}