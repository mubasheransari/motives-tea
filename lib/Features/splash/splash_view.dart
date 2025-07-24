import 'dart:async';
import 'package:attendence_app/Features/home/home_view.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // late StreamSubscription<ConnectivityResult> _subscription;
  late StreamSubscription<List<ConnectivityResult>> _subscription;

  bool _navigated = false;
  //bool? isConnected;

  @override
  void initState() {
    super.initState();
    _checkInternetAndNavigate();

    _subscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> resultList) async {
      // Check if any result in the list is not 'none'
      final hasConnection = resultList.any((result) =>
          result != ConnectivityResult.none &&
          result != ConnectivityResult.other);

     final isConnected = hasConnection && await _hasInternetConnection();
      print("CONNECTED $isConnected");
      print("CONNECTED $isConnected");
      print("CONNECTED $isConnected");
      print("CONNECTED $isConnected");
      print("CONNECTED $isConnected");
      print("CONNECTED $isConnected");
      print("CONNECTED $isConnected");
      print("CONNECTED $isConnected");

          _navigated = true;
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (context) => HomeScreen(
                    connectivity: isConnected,
                  )),
        );
      }
    });

      // if (isConnected && !_navigated) {
      //   _navigateToHome();
      // } else if (!isConnected) {
      //   _showNoInternetMessage();
      //   _navigateToHome();
      // }
    });
  }

  Future<void> _checkInternetAndNavigate() async {
    bool isConnected = await _hasInternetConnection();
    if (isConnected) {
      _navigateToHome();
    } else {
      _showNoInternetMessage();
    }
  }

  Future<bool> _hasInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException {
      return false;
    }
  }

  void _navigateToHome() {
    _navigated = true;
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (context) => HomeScreen(
                    connectivity: true,
                  )),
        );
      }
    });
  }

  void _showNoInternetMessage() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final messenger = ScaffoldMessenger.maybeOf(context);
      if (messenger != null) {
        messenger.showSnackBar(
          const SnackBar(
            content: Text('No internet connection. Please check your network.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE6DCFD), Color(0xFFD8E7FF)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 310.0),
              child: Image.asset(
                "assets/logo.png",
                height: 166,
              ),
            ),
            const Spacer(),
            const Padding(
              padding: EdgeInsets.only(bottom: 30.0),
              child: Text(
                'Powered by MEZANGRP',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


/*class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to HomeScreen after 3 seconds
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          //color: Colors.white
          gradient: LinearGradient(
            colors: [
              Color(0xFFE6DCFD),
              Color(0xFFD8E7FF),

              //Color(0xFF6495ED) // Color(0xFFD8E7FF),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 310.0),
              child: Image.asset(
                "assets/logo.png",
                //  width: 160,
                height: 166,
              ),
            ),
            const Spacer(),
            const Padding(
              padding: EdgeInsets.only(bottom: 30.0),
              child: Text(
                'Powered by MEZANGRP',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/



// class SplashScreen extends StatefulWidget {
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     // Navigate to HomeScreen after 3 seconds
//     Timer(Duration(seconds: 3), () {
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (context) => HomeScreen()),
//       );
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: MediaQuery.of(context).size.width,
//         decoration: const BoxDecoration(
//           //color: Colors.white
//           gradient: LinearGradient(
//             colors: [
//               Color(0xFFE6DCFD),
//               Color(0xFFD8E7FF),

//               //Color(0xFF6495ED) // Color(0xFFD8E7FF),
//             ],
//             begin: Alignment.centerLeft,
//             end: Alignment.centerRight,
//           ),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(top: 310.0),
//               child: Image.asset(
//                 "assets/logo.png",
//                 //  width: 160,
//                 height: 166,
//               ),
//             ),
//             const Spacer(),
//             const Padding(
//               padding: EdgeInsets.only(bottom: 30.0),
//               child: Text(
//                 'Powered by MEZANGRP',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.w300,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
