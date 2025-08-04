import 'package:attendence_app/Features/splash/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'Features/Route/route_view.dart';

void main() async{
   await GetStorage.init();
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: time != null ? RouteGoogleMap(): SplashScreen()
    );
  }
}

