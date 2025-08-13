import 'package:attendence_app/Features/login/login_view.dart';
import 'package:attendence_app/Features/punch_order/products_screen.dart';
import 'package:attendence_app/Features/splash/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';

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

