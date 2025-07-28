import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../../widgets/customScaffoldWidget.dart';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:geocoding/geocoding.dart';

/*class MarkedAttendenceView extends StatefulWidget {
  const MarkedAttendenceView({super.key});

  @override
  State<MarkedAttendenceView> createState() => _MarkedAttendenceViewState();
}

class _MarkedAttendenceViewState extends State<MarkedAttendenceView> {
  final loc.Location location = loc.Location();
  late GoogleMapController _mapController;
  Set<Marker> _markers = {};
  BitmapDescriptor? _customMarkerIcon;
  String? _currentAddress;

  static final CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(30.3753, 69.3451),
    zoom: 5,
  );

  late Future<void> _initLocationFuture;

    Future<void> _loadCustomMarker() async {
    final BitmapDescriptor bitmapDescriptor =
        await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(devicePixelRatio: 5.5),
      'assets/mapicon_removebg.png',
    );
    setState(() {
      _customMarkerIcon = bitmapDescriptor;
    });
  }

  @override
  void initState() {
    super.initState();
    _initLocationFuture = _requestPermissionAndFetchLocation();
    _loadCustomMarker();
  }



  Future<void> _requestPermissionAndFetchLocation() async {
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) return;
    }

    loc.PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == loc.PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != loc.PermissionStatus.granted) return;
    }

    // Enable high accuracy
    location.changeSettings(
      accuracy: loc.LocationAccuracy.high,
      interval: 1000,
      distanceFilter: 1,
    );

    loc.LocationData currentLocation = await location.getLocation();

    LatLng currentLatLng = LatLng(
      currentLocation.latitude ?? 30.3753,
      currentLocation.longitude ?? 69.3451,
    );

    // Reverse geocoding
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        currentLatLng.latitude,
        currentLatLng.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        String address =
            "${place.name}, ${place.street}, ${place.subLocality}, ${place.locality}, ${place.administrativeArea}, ${place.postalCode}, ${place.country}";

        setState(() {
          _currentAddress = address;
        });
      }
    } catch (e) {
      debugPrint("Error getting address: $e");
    }

    // Add only your custom marker
    if (_customMarkerIcon != null) {
      setState(() {
        _markers.clear();
        _markers.add(
          Marker(
            markerId: const MarkerId('custom_marker'),
            position: currentLatLng,
            icon: _customMarkerIcon!,
            infoWindow: const InfoWindow(title: 'Your Location'),
          ),
        );
      });
    }

    _mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: currentLatLng, zoom: 18),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance'),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            width: double.infinity,
            color: Colors.white,
            child: _currentAddress != null
                ? Text(
                    _currentAddress!,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  )
                : const Text(
                    'Fetching your address...',
                    style: TextStyle(fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: FutureBuilder(
              future: _initLocationFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const Center(child: CircularProgressIndicator());
                }

                return ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: GoogleMap(
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: _initialCameraPosition,
                    markers: _markers,
                    mapType: MapType.normal,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: false,
                    zoomControlsEnabled: false,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

*/

import 'dart:async';

import '../NavBar/custom_navbar.dart';
import '../NavBar/drawer_menu_button.dart';

class MarkedAttendenceView extends StatefulWidget {
  const MarkedAttendenceView({super.key});

  @override
  State<MarkedAttendenceView> createState() => _MarkedAttendenceViewState();
}

class _MarkedAttendenceViewState extends State<MarkedAttendenceView> {
  final loc.Location location = loc.Location();
  late GoogleMapController _mapController;
  Set<Marker> _markers = {};
  BitmapDescriptor? _customMarkerIcon;
  String? _currentAddress;
  CameraPosition? _cameraPosition;

  late Future<void> _initLocationFuture;

  Future<void> _loadCustomMarker() async {
    final BitmapDescriptor bitmapDescriptor =
        await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(
          devicePixelRatio: 2, size: Size.lerp(Size.zero, Size.zero, 20)),
      'assets/g_marker.png',
    );
    setState(() {
      _customMarkerIcon = bitmapDescriptor;
    });
  }

  @override
  void initState() {
    super.initState();
    _initLocationFuture = _requestPermissionAndFetchLocation();
    _loadCustomMarker();
  }

  Future<void> _requestPermissionAndFetchLocation() async {
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) return;
    }

    loc.PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == loc.PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != loc.PermissionStatus.granted) return;
    }

    location.changeSettings(
      accuracy: loc.LocationAccuracy.high,
      interval: 1000,
      distanceFilter: 1,
    );

    loc.LocationData currentLocation = await location.getLocation();

    LatLng currentLatLng = LatLng(
      currentLocation.latitude ?? 30.3753,
      currentLocation.longitude ?? 69.3451,
    );

    _cameraPosition = CameraPosition(target: currentLatLng, zoom: 18);

    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        currentLatLng.latitude,
        currentLatLng.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        String address =
            "${place.name}, ${place.street}, ${place.subLocality}, ${place.locality}, ${place.administrativeArea}, ${place.postalCode}, ${place.country}";

        setState(() {
          _currentAddress = address;
        });
      }
    } catch (e) {
      debugPrint("Error getting address: $e");
    }

    if (_customMarkerIcon != null) {
      setState(() {
        _markers.clear();
        _markers.add(
          Marker(
            markerId: const MarkerId('custom_marker'),
            position: currentLatLng,
            icon: _customMarkerIcon!,
            infoWindow: const InfoWindow(title: 'Your Location'),
          ),
        );
      });
    }

    if (_mapController != null) {
      _mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: currentLatLng, zoom: 18),
        ),
      );
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
         key: _scaffoldKey, // ✅ Add this line
    drawer: CustomNavDrawer(), // ✅ Add your drawer if not already
      // appbartitle: 'Attendence',
      // isAppBarContentRequired: true,
      // isDrawerRequired: true,
      body: Stack(
        children: [
          /* Container(
            padding: const EdgeInsets.all(12),
            width: double.infinity,
            color: Colors.white,
            child: _currentAddress != null
                ? Text(
                    _currentAddress!,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  )
                : const Text(
                    'Fetching your address...',
                    style: TextStyle(fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
          ),
          const SizedBox(height: 10),*/
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.90,
            width: MediaQuery.of(context).size.width,
            child: FutureBuilder(
              future: _initLocationFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done ||
                    _cameraPosition == null) {
                  return const Center(child: CircularProgressIndicator());
                }

                return ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: GoogleMap(
                    padding: EdgeInsets.only(bottom: 40),
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: _cameraPosition!,
                    mapType: MapType.normal,
                    markers: _markers,
                    myLocationButtonEnabled: false,
                    zoomControlsEnabled: true,
                  ),
                );
              },
            ),
          ),
          Positioned(
            top: 38,
            left: 16,
            child: DrawerMenuButton(scaffoldKey: _scaffoldKey),
          ),
        ],
      ),
    );
  }
}



// class MarkedAttendenceView extends StatefulWidget {
//   const MarkedAttendenceView({super.key});

//   @override
//   State<MarkedAttendenceView> createState() => _MarkedAttendenceViewState();
// }

// class _MarkedAttendenceViewState extends State<MarkedAttendenceView> {
//   final loc.Location location = loc.Location();
//   late GoogleMapController _mapController;
//   Set<Marker> _markers = {};
//   BitmapDescriptor? _customMarkerIcon;
//   String? _currentAddress;

//   static final CameraPosition _initialCameraPosition = CameraPosition(
//     target: LatLng(30.3753, 69.3451),
//     zoom: 15,
//   );

//   late Future<void> _initLocationFuture;

//     Future<void> _loadCustomMarker() async {
//     final BitmapDescriptor bitmapDescriptor =
//         await BitmapDescriptor.fromAssetImage(
//       const ImageConfiguration(devicePixelRatio: 5.5),
//       'assets/mapicon_removebg.png',
//     );
//     setState(() {
//       _customMarkerIcon = bitmapDescriptor;
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     _initLocationFuture = _requestPermissionAndFetchLocation();
//     _loadCustomMarker();
//   }



//   Future<void> _requestPermissionAndFetchLocation() async {
//     bool serviceEnabled = await location.serviceEnabled();
//     if (!serviceEnabled) {
//       serviceEnabled = await location.requestService();
//       if (!serviceEnabled) return;
//     }

//     loc.PermissionStatus permissionGranted = await location.hasPermission();
//     if (permissionGranted == loc.PermissionStatus.denied) {
//       permissionGranted = await location.requestPermission();
//       if (permissionGranted != loc.PermissionStatus.granted) return;
//     }

//     // Enable high accuracy
//     location.changeSettings(
//       accuracy: loc.LocationAccuracy.high,
//       interval: 1000,
//       distanceFilter: 1,
//     );

//     loc.LocationData currentLocation = await location.getLocation();

//     LatLng currentLatLng = LatLng(
//       currentLocation.latitude ?? 30.3753,
//       currentLocation.longitude ?? 69.3451,
//     );

//     // Reverse geocoding
//     try {
//       List<Placemark> placemarks = await placemarkFromCoordinates(
//         currentLatLng.latitude,
//         currentLatLng.longitude,
//       );

//       if (placemarks.isNotEmpty) {
//         Placemark place = placemarks.first;
//         String address =
//             "${place.name}, ${place.street}, ${place.subLocality}, ${place.locality}, ${place.administrativeArea}, ${place.postalCode}, ${place.country}";

//         setState(() {
//           _currentAddress = address;
//         });
//       }
//     } catch (e) {
//       debugPrint("Error getting address: $e");
//     }

//     // Add only your custom marker
//     if (_customMarkerIcon != null) {
//       setState(() {
//         _markers.clear();
//         _markers.add(
//           Marker(
//             markerId: const MarkerId('custom_marker'),
//             position: currentLatLng,
//             icon: _customMarkerIcon!,
//             infoWindow: const InfoWindow(title: 'Your Location'),
//           ),
//         );
//       });
//     }

//     _mapController.animateCamera(
//       CameraUpdate.newCameraPosition(
//         CameraPosition(target: currentLatLng, zoom: 18),
//       ),
//     );
//   }

//   void _onMapCreated(GoogleMapController controller) {
//     _mapController = controller;
//   }


//   @override
//   Widget build(BuildContext context) {
//     return CustomScaffoldWidget(
//       appbartitle: 'Attendence',
//       isAppBarContentRequired: true,
//       isDrawerRequired: true,
//       body: Column(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(12),
//             width: double.infinity,
//             color: Colors.white,
//             child: _currentAddress != null
//                 ? Text(
//                     _currentAddress!,
//                     style: const TextStyle(
//                       fontSize: 15,
//                       fontWeight: FontWeight.w500,
//                     ),
//                     textAlign: TextAlign.center,
//                   )
//                 : const Text(
//                     'Fetching your address...',
//                     style: TextStyle(fontSize: 14),
//                     textAlign: TextAlign.center,
//                   ),
//           ),
//           // Container(
//           //   height: MediaQuery.of(context).size.height * 0.10,
//           //   width: MediaQuery.of(context).size.width * 0.95,
//           //   decoration: BoxDecoration(color: Colors.white),
//           // ),
//           SizedBox(
//             height: 10,
//           ),
//           // Google Map
//           SizedBox(
//             height: MediaQuery.of(context).size.height * 0.70,
//             width: MediaQuery.of(context).size.width,
//             child: FutureBuilder(
//               future: _initLocationFuture,
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState != ConnectionState.done) {
//                   return const Center(child: CircularProgressIndicator());
//                 }

//                 return ClipRRect(
//                   borderRadius: BorderRadius.circular(24),
//                   child: GoogleMap(
//                     padding: const EdgeInsets.only(bottom: 40),
//                     onMapCreated: _onMapCreated,
//                     initialCameraPosition: _initialCameraPosition,
//                     mapType: MapType.normal,
//                     markers: _markers,
//                     myLocationButtonEnabled: false,
//                     zoomControlsEnabled: true,
//                   ),
//                 );
//               },
//             ),
//           ),
//           // Container(
//           //   height: 40,
//           //   width: MediaQuery.of(context).size.width * 0.80,
//           //   decoration: BoxDecoration(color: Colors.white),
//           // ),

//           // Menu Icon (top-left)
//           /*    Positioned(
//             top: 40,
//             left: 16,
//             child: GestureDetector(
//               onTap: () {
//                 _scaffoldKey.currentState
//                     ?.openDrawer(); //  Scaffold.of(context).openDrawer(); // ← Opens the drawer
//               },
//               child: Container(
//                 padding: const EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   shape: BoxShape.circle,
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.15),
//                       blurRadius: 8,
//                       offset: const Offset(0, 2),
//                     ),
//                   ],
//                 ),
//                 child: const Icon(Icons.menu, size: 28, color: Colors.black87),
//               ),
//             ),
//           ),*/
//         ],
//       ),
//     );
//   }
// }
