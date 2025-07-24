import 'package:flutter/material.dart';

class DrawerMenuButton extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const DrawerMenuButton({super.key, required this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        scaffoldKey.currentState?.openDrawer();
      },
      child: const CircleAvatar(
        radius: 22,
        backgroundColor: Colors.white,
        child: Image(
          image: AssetImage("assets/menu-02.png"),
        ),
      ),
    );
  }
}
