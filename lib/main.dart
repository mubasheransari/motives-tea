import 'package:attendence_app/Features/login/login_view.dart';
import 'package:attendence_app/Features/punch_order/products_screen.dart';
import 'package:attendence_app/Features/splash/splash_view.dart';
import 'package:attendence_app/Features/theme_change/bloc/theme_change_bloc.dart';
import 'package:attendence_app/Features/theme_change/bloc/theme_change_state.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main() {
  runApp(
    BlocProvider(
      create: (_) => ThemeBloc(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

final lightTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.blue,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.blue,
    elevation: 0,
  ),
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.deepPurple,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black,
    elevation: 0,
  ),
);

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Theme BLoC',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: state.themeMode,
          home: SplashScreen(),
        );
      },
    );
  }
}

/*
void main() async{
   await GetStorage.init();
   await PersistentShoppingCart().init();
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
     final storage = GetStorage();
    var time = storage.read("checkin_time");
    return MaterialApp(
      title: 'Motives-T',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: SplashScreen()       
      // time != null ? HomeDashboard() //RouteGoogleMap()
      // : SplashScreen()
    );     
  }
}

*/