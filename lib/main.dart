import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:travel_app/screens/manager/app_manager/app_cubit.dart';
import 'package:travel_app/model/shared.dart';
import 'package:travel_app/screens/welcome_page.dart';
import 'generated/l10n.dart';

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
          locale: Locale(PreferenceUtils.getString(PrefKeys.language)),
          supportedLocales :S.delegate.supportedLocales,
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        title: 'Flutter Demo',
            theme:
            ThemeData(
                brightness: Brightness.light,
                useMaterial3: false,
                primarySwatch: Colors.blue,
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
                      color: Color(0XFF0096c7),
                      fontSize: 15,
                    ),
                    titleMedium: TextStyle(
                      color: Color(0XFF023e8a),
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                    titleLarge: TextStyle(
                        color: Color(0XFF03045e),
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
                      color: Color(0XFF95d5b2),
                      fontSize: 15,
                    ),
                    titleMedium: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500
                    ),
                    titleLarge: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold
                    )
                ),
                iconTheme: IconThemeData(color: Color(0XFF95d5b2))
            ),

            themeMode: PreferenceUtils.getBool(PrefKeys.darkTheme)
                ? ThemeMode.dark
                : ThemeMode.light,
            debugShowCheckedModeBanner: false,
            home: WelcomePage()
          );
        },
      )
    );
  }
}

