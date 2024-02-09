

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:travel_app/screens/manager/app_manager/app_cubit.dart';
import 'package:travel_app/screens/notification.dart';
import 'package:travel_app/screens/select_country.dart';
import 'package:travel_app/screens/select_language.dart';
import 'package:travel_app/screens/test_noti.dart';
import 'package:travel_app/shared.dart';


class NewsSettingsScreen extends StatefulWidget {
  const NewsSettingsScreen({super.key});

  @override
  State<NewsSettingsScreen> createState() => _NewsSettingsScreenState();
}

class _NewsSettingsScreenState extends State<NewsSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return
      Drawer(
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20,bottom: 10),
            child: Center(child: Text("Setting",style: Theme.of(context).textTheme.titleMedium)),
          ),
          settingItem(
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: SelectCountryScreen(),
                    duration: Duration(milliseconds: 300)
                ),
              ).then((value) => setState(() {}));
            },
            icon: Icons.language_rounded,
            title: "country",
            value: PreferenceUtils.getString(PrefKeys.newsCountry),
          ),
          settingItem(
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: NotificationScreen(),
                    duration: Duration(milliseconds: 300)
                ),
              ).then((value) => setState(() {}));
            },
            icon: Icons.notifications,
            title: 'Notifications',
            value: PreferenceUtils.getString(PrefKeys.notification),
          ),
          settingItem(
              onTap: () => showChangeThemeBottomSheet(),
              icon: Icons.color_lens_rounded,
              title: 'theme',
              value: PreferenceUtils.getBool(PrefKeys.darkTheme)
                  ? 'dark'
                  : 'light'),

          settingItem(
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: SelectLanguageScreen(),
                      duration: Duration(milliseconds: 300)
                  ),
                ).then((value) => setState(() {}));
              },
              icon: Icons.language_rounded,
              title: 'Language',
              value:PreferenceUtils.getString(PrefKeys.language)),
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
              style: Theme.of(context).textTheme.titleSmall,

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
        return
          Container(
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35),
                topRight:Radius.circular(35) ),
            ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children:[
                const SizedBox(height: 20),
                 Text('Select Theme',style: Theme.of(context).textTheme.titleSmall,),
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
                    child:  Text(
                      'Light',
                   style: Theme.of(context).textTheme.titleMedium,
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
                    child:  Text(
                      'Dark',
                    style: Theme.of(context).textTheme.titleMedium,
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