import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/screens/bar_item_pages/main_page.dart';
import 'package:travel_app/screens/countries_screen/australia.dart';
import 'package:travel_app/screens/manager/app_manager/app_cubit.dart';
import 'package:travel_app/screens/setting.dart';
import 'package:travel_app/shared.dart';
import 'package:travel_app/screens/welcome_page.dart';
import 'package:travel_app/search_bar/search_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await PreferenceUtils.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit(),
        )
      ],
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          return MaterialApp(
              title: 'Flutter Demo',
              theme:
              ThemeData(
                brightness: Brightness.light,
                  useMaterial3: false,
                  primarySwatch: Colors.green,
                  appBarTheme: AppBarTheme(
                      color: Colors.white,
                    titleTextStyle: TextStyle(
                      color: Colors.blue,
                      fontSize: 20
                    ),
                    iconTheme: IconThemeData(color: Colors.blue)
                  ),
                scaffoldBackgroundColor: Colors.white,
                textTheme: TextTheme(
                    titleSmall: TextStyle(
                      color: Colors.blue,
                      fontSize: 14,
                    ),
                  titleMedium: TextStyle(
                    color: Colors.blue,
                    fontSize: 18
                  ),
                    titleLarge: TextStyle(
                        color: Colors.blue,
                        fontSize: 30,
                      fontWeight: FontWeight.bold
                    )
                ),
                  iconTheme: IconThemeData(color: Colors.blue)

              ),

              darkTheme:
              ThemeData(
                brightness: Brightness.dark,
                  primarySwatch: Colors.grey,
                  appBarTheme: AppBarTheme(
                      color: Colors.black87,
          titleTextStyle: TextStyle(
            fontSize: 20,
          color: Colors.white
                  ),
                      iconTheme: IconThemeData(color: Colors.white)
              ),
                  scaffoldBackgroundColor: Colors.black87,
                  textTheme: TextTheme(
                      titleSmall: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                      ),
              titleMedium: TextStyle(
              color: Colors.white,
                  fontSize: 19,
                fontWeight: FontWeight.w700
              ),
                      titleLarge: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                        fontWeight: FontWeight.bold
                      )
          ),
                iconTheme: IconThemeData(color: Colors.white)
              ),

              themeMode: PreferenceUtils.getBool(PrefKeys.darkTheme)
                  ? ThemeMode.dark
                  : ThemeMode.light,
              debugShowCheckedModeBanner: false,
              home:MainPage()
          );
        },
      ),
    );
  }
}
