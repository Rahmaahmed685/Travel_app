

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/screens/manager/app_manager/app_cubit.dart';
import 'package:travel_app/screens/select_country.dart';
import 'package:travel_app/shared.dart';


class NewsSettingsScreen extends StatefulWidget {
  const NewsSettingsScreen({super.key});

  @override
  State<NewsSettingsScreen> createState() => _NewsSettingsScreenState();
}

class _NewsSettingsScreenState extends State<NewsSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings'),
        elevation: 0,
      ),
      body: Column(
        children: [
          settingItem(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NewsSelectCountryScreen(),
                ),
              ).then((value) => setState(() {}));
            },
            icon: Icons.language_rounded,
            title: "country",
            value: PreferenceUtils.getString(PrefKeys.newsCountry),
          ),
          settingItem(
            onTap: () {},
            icon: Icons.notifications,
            title: 'Notifications',
          ),
          settingItem(
              onTap: () => showChangeThemeBottomSheet(),
              icon: Icons.color_lens_rounded,
              title: 'theme',
              value: PreferenceUtils.getBool(PrefKeys.darkTheme)
                  ? 'dark'
                  : 'light'),
          
          settingItem(
              onTap: () {},
              icon: Icons.language_rounded,
              title: 'Language',
              value: 'en'),
        ],
      ),
    );
  }

  Widget settingItem({
    required GestureTapCallback onTap,
    required IconData icon,
    required String title,
    String value = '',
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            Icon(
              icon,
            ),
            const SizedBox(width: 5),
            Text(
              title,
              style:Theme.of(context).textTheme.titleMedium,
            ),
            const Spacer(),
            Text(
              value,
              style: Theme.of(context).textTheme.titleMedium,

              ),

            const SizedBox(width: 5),
            const Icon(Icons.keyboard_arrow_right_rounded, ),
          ],
        ),
      ),
    );
  }


  showChangeThemeBottomSheet() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight:Radius.circular(25) ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(height: 20),
                const Text('Select Theme'),
                InkWell(
                  onTap: () async {
                    await PreferenceUtils.setBool(
                      PrefKeys.darkTheme,
                      false,
                    );
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'Light',
                      style: TextStyle(
                        fontSize: 22,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () async {
                    await PreferenceUtils.setBool(
                      PrefKeys.darkTheme,
                      true,
                    );
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    // color: Colors.grey[200],
                    child: const Text(
                      'Dark',
                      style: TextStyle(
                        fontSize: 22,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ).then((value) {
      BlocProvider.of<AppCubit>(context).themeChanged();
    });
  }



}