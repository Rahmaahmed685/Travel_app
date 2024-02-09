import 'package:flutter/material.dart';

import '../shared.dart';
class SelectNotiScreen extends StatefulWidget {
  const SelectNotiScreen({super.key});

  @override
  State<SelectNotiScreen> createState() =>
      _SelectNotiScreenState();
}

class _SelectNotiScreenState extends State<SelectNotiScreen> {
  final noti = [
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
        itemCount: noti.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () => saveSelectedCountry(noti[index]),
            child: Container(
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(noti[index],style: Theme.of(context).textTheme.titleSmall,),
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

  saveSelectedCountry(String selectedNoti) {
    PreferenceUtils.setString(
      PrefKeys.notification,
      selectedNoti,
    );

    Navigator.pop(context);
  }
}