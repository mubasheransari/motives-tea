import 'package:flutter/material.dart';
import '../Features/navbar/custom_navbar.dart';
import '../Features/navbar/drawer_menu_button.dart';


class CustomScaffoldWidget extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? drawer;
  final bool isDrawerRequired;
  final String appbartitle;
  final bool isAppBarContentRequired;
  final bool showNotificationIcon;

  const CustomScaffoldWidget({
    Key? key,
    required this.body,
    required this.appbartitle,
    this.appBar,
    this.drawer,
    this.isDrawerRequired = false,
    this.isAppBarContentRequired = true,
    this.showNotificationIcon = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      drawer: drawer ?? CustomNavDrawer(),
      appBar: appBar,
      backgroundColor: const Color(0xFFF5F7FA),
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFE6DCFD),
              Color(0xFFD8E7FF),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              if (isAppBarContentRequired)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      isDrawerRequired
                          ? DrawerMenuButton(scaffoldKey: scaffoldKey)
                          : InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const CircleAvatar(
                                radius: 22,
                                backgroundColor: Colors.white,
                                child: Icon(Icons.arrow_back,
                                    color: Colors.black),
                              ),
                            ),
                      Padding(
                        padding: const EdgeInsets.only(left: 19.0),
                        child: Center(
                          child: Text(
                            appbartitle.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(), // You can replace this with notification icon if needed
                      const SizedBox(),
                    ],
                  ),
                ),
              Expanded(child: body),
            ],
          ),
        ),
      ),
    );
  }
}


/*class CustomScaffoldWidget extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? drawer;
  final bool isDrawerRequired;
  final String appbartitle;
  final bool isAppBarContentRequired;
  final bool showNotificationIcon;

  const CustomScaffoldWidget({
    Key? key,
    required this.body,
    required this.appbartitle,
    this.appBar,
    this.drawer,
    this.isDrawerRequired = false,
    this.isAppBarContentRequired = true,
    this.showNotificationIcon = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomNavDrawer(),
      appBar: appBar,
      backgroundColor: const Color(0xFFF5F7FA),
      body: DecoratedBox(
        //  decoration: boxDecoration(),\
        decoration: BoxDecoration(
        //  color: Colors.grey
          gradient: LinearGradient(
            colors: [
              Color(0xFFE6DCFD),
              Color(0xFFD8E7FF),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              if (isAppBarContentRequired)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      isDrawerRequired
                          ? InkWell(
                              onTap: () {
                                _scaffoldKey.currentState?.openDrawer();
                              },
                              child: CircleAvatar(
                                radius: 22,
                                backgroundColor: Colors.white,
                                child: Image.asset("assets/menu-02.png"),
                              ),
                            )
                          : InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const CircleAvatar(
                                radius: 22,
                                backgroundColor: Colors.white,
                                child:
                                    Icon(Icons.arrow_back, color: Colors.black),
                              ),
                            ),
                      // SizedBox(width: 2,),
                      Padding(
                        padding: const EdgeInsets.only(left: 19.0),
                        child: Center(
                          child: Text(
                            appbartitle.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                             // fontFamily: 'Satoshi',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(),
                      SizedBox()
                      // InkWell(
                      //   onTap: () {

                      //   },
                      //   child: CircleAvatar(
                      //     radius: 22,
                      //     backgroundColor: Colors.white,
                      //     child: Image.asset(
                      //       "assets/disclaimer.png",
                      //       height: 35,
                      //       width: 35,
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                ),
              Expanded(child: body),
            ],
          ),
        ),
      ),
    );
  }
}

*/




/*class CustomScaffoldWidget extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? drawer;
  final bool isDrawerRequired;
  final String appbartitle;
  final bool isAppBarContentRequired;
  final bool showNotificationIcon;

  const CustomScaffoldWidget({
    Key? key,
    required this.body,
    required this.appbartitle,
    this.appBar,
    this.drawer,
    this.isDrawerRequired = false,
    this.isAppBarContentRequired = true,
    this.showNotificationIcon = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomNavDrawer(),
      appBar: appBar,
      backgroundColor: const Color(0xFFF5F7FA),
      body: DecoratedBox(
        //  decoration: boxDecoration(),\
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFE6DCFD),
              Color(0xFFD8E7FF),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              if (isAppBarContentRequired)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      isDrawerRequired
                          ? InkWell(
                              onTap: () {
                                _scaffoldKey.currentState?.openDrawer();
                              },
                              child: CircleAvatar(
                                radius: 22,
                                backgroundColor: Colors.white,
                                child: Image.asset("assets/menu-02.png"),
                              ),
                            )
                          : InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const CircleAvatar(
                                radius: 22,
                                backgroundColor: Colors.white,
                                child:
                                    Icon(Icons.arrow_back, color: Colors.black),
                              ),
                            ),
                      Center(
                        child: Text(
                          appbartitle,
                          style: const TextStyle(
                            fontSize: 24,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Satoshi',
                          ),
                        ),
                      ),
                      SizedBox(),
                      // InkWell(
                      //   onTap: () {
                      //     Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //             builder: (context) => DisclaimerView()));
                      //   },
                      //   child: CircleAvatar(
                      //     radius: 22,
                      //     backgroundColor: Colors.white,
                      //     child: Image.asset(
                      //       "assets/disclaimer.png",
                      //       height: 35,
                      //       width: 35,
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                ),
              Expanded(child: body),
            ],
          ),
        ),
      ),
    );
  }
}*/
