import 'dart:io';

import 'package:attendence_app/Features/home/home_view.dart';
import 'package:attendence_app/Features/home_dashboard/home_dashboard.dart';
import 'package:attendence_app/widgets/toast_widget.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart' as loc;
import '../navbar/custom_navbar.dart';
import '../navbar/drawer_menu_button.dart';

class MarkAttendanceView extends StatefulWidget {
  const MarkAttendanceView({super.key});

  @override
  State<MarkAttendanceView> createState() => _MarkAttendanceViewState();
}

class _MarkAttendanceViewState extends State<MarkAttendanceView> {
  final loc.Location location = loc.Location();
  late GoogleMapController _mapController;
  Set<Marker> _markers = {};
  BitmapDescriptor? _currentMarkerIcon;
  BitmapDescriptor? _shopMarkerIcon;
  LatLng? _currentLatLng;
  CameraPosition? _initialCameraPosition;
  String distanceInfo = "";

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isMapReady = false;

  @override
  void initState() {
    super.initState();
    _initMap();
  }

  Future<void> _initMap() async {
    await _loadCustomMarkers();
    await _requestPermissionAndFetchLocation();
    // _addRandomShopMarkers();
    setState(() {
      _isMapReady = true;
      distanceInfo = '';
    });
  }

  Future<void> _loadCustomMarkers() async {
    _currentMarkerIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(devicePixelRatio: 2.5),
      'assets/g_marker.png',
    );

    // _shopMarkerIcon = await BitmapDescriptor.fromAssetImage(
    //   const ImageConfiguration(devicePixelRatio: 2.5),
    //   'assets/shop_icon_marker.png',
    // );
  }

  Future<void> _requestPermissionAndFetchLocation() async {
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) return;
    }

    var permissionGranted = await location.hasPermission();
    if (permissionGranted == loc.PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != loc.PermissionStatus.granted) return;
    }

    final currentLocation = await location.getLocation();
    _currentLatLng = LatLng(
      currentLocation.latitude ?? 24.8607,
      currentLocation.longitude ?? 67.0011,
    );

    _initialCameraPosition = CameraPosition(target: _currentLatLng!, zoom: 14);

    if (_currentMarkerIcon != null) {
      _markers.add(
        Marker(
          markerId: const MarkerId('current_location'),
          position: _currentLatLng!,
          icon: _currentMarkerIcon!,
          infoWindow: const InfoWindow(title: 'Your Location'),
        ),
      );
    }
  }

  // void _addRandomShopMarkers() {
  //   final List<LatLng> randomShops = [
  //     const LatLng(24.8615, 67.0099),
  //     const LatLng(24.8581, 67.0136),
  //     const LatLng(24.8672, 67.0211),
  //     const LatLng(24.8569, 67.0012),
  //     const LatLng(24.8703, 67.0455),
  //   ];

  //   for (int i = 0; i < randomShops.length; i++) {
  //     final shopId = 'shop_$i';
  //     final shopLatLng = randomShops[i];

  //     _markers.add(
  //       Marker(
  //         markerId: MarkerId(shopId),
  //         position: shopLatLng,
  //         icon: _shopMarkerIcon ?? BitmapDescriptor.defaultMarker,
  //         infoWindow: InfoWindow(title: 'Location ${i + 1}'),
  //         onTap: () {
  //           _showTappedMarkerDistance(shopLatLng, 'Location ${i + 1}');
  //         },
  //       ),
  //     );
  //   }
  // 

  void _showTappedMarkerDistance(LatLng target, String name) {
    if (_currentLatLng == null) return;

    double distanceInMeters = Geolocator.distanceBetween(
      _currentLatLng!.latitude,
      _currentLatLng!.longitude,
      target.latitude,
      target.longitude,
    );

    setState(() {
      distanceInfo =
          'Distance: ${(distanceInMeters / 1000).toStringAsFixed(2)} km (to $name)';
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  final ImagePicker _picker = ImagePicker();
  File? _capturedImage;

  void _markAttendance() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    DateTime now = DateTime.now();

    String formattedTime = DateFormat('hh:mm a').format(now); // e.g., 03:45 PM
    String formattedDate =
        DateFormat('yyyy-MM-dd').format(now); // e.g., 2025-08-03
    final storage = GetStorage();
    storage.write("checkin_time", formattedTime);
    storage.write("checkin_date", formattedDate);
    if (photo != null) {
      setState(() {
        _capturedImage = File(photo.path);
      });

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HomeDashboard()));

      toastWidget(
          "Your Attendence is marked successfully at $formattedTime on $formattedDate.",
          Colors.green);

      /*  showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Dialog(
          insetPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // slight curve
          ),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.5, // dialog height
            width: MediaQuery.of(context).size.width * 0.9, // dialog width
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    'Attendance Details',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: MediaQuery.of(context).size.width *
                        0.9 *
                        0.7, // 70% of dialog width
                    height: MediaQuery.of(context).size.height *
                        0.5 *
                        0.5, // 50% of dialog height
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        _capturedImage!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    formattedDate,
                    style: const TextStyle(fontSize: 14),
                  ),
                  const Spacer(),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Close'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );*/
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Camera cancelled or failed')),
      );
    }
  }

// void _markAttendance() async {
//   final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
//   DateTime now = DateTime.now();
//     String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);
//   if (photo != null) {
//     setState(() {
//       _capturedImage = File(photo.path);
//     });

//     // Show captured image in dialog
//     showDialog(
//       context: context,
//       builder: (context) => SizedBox(
//         height: MediaQuery.of(context).size.height*0.30,
//         child: AlertDialog(

//           title: const Text('Attendence Details',style: TextStyle(fontSize: 15),),
//           content: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Image.file(_capturedImage!),
//               SizedBox(height: 10,),
//               Text(formattedDate),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: const Text('Close'),
//             ),
//           ],
//         ),
//       ),
//     );
//   } else {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('Camera cancelled or failed')),
//     );
//   }
// }

  // void _markAttendance() {
  //   // TODO: Replace with real logic
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     const SnackBar(content: Text('Attendance marked!')),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //key: _scaffoldKey,
      //  drawer: CustomNavDrawer(),
      body: Stack(
        children: [
          if (_isMapReady && _initialCameraPosition != null)
            GoogleMap(
              padding: const EdgeInsets.only(bottom: 60),
              onMapCreated: _onMapCreated,
              initialCameraPosition: _initialCameraPosition!,
              mapType: MapType.normal,
              markers: _markers,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
            ),
          // Positioned(
          //   top: 38,
          //   left: 16,
          //   child: DrawerMenuButton(scaffoldKey: _scaffoldKey),
          // ),
          if (distanceInfo.isNotEmpty)
            Positioned(
              bottom: 30,
              left: 16,
              right: 16,
              child: Container(
                padding: const EdgeInsets.all(0),
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  distanceInfo,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          Positioned(
            bottom: 30,
            left: 16,
            right: 16,
            child: ElevatedButton(
              onPressed: _markAttendance,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Mark Attendance',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}



// class MarkAttendanceView extends StatefulWidget {
//   const MarkAttendanceView({super.key});

//   @override
//   State<MarkAttendanceView> createState() => _MarkAttendanceViewState();
// }

// class _MarkAttendanceViewState extends State<MarkAttendanceView> {
//   final loc.Location location = loc.Location();
//   late GoogleMapController _mapController;
//   Set<Marker> _markers = {};
//   BitmapDescriptor? _currentMarkerIcon;
//   BitmapDescriptor? _shopMarkerIcon;
//   LatLng? _currentLatLng;
//   CameraPosition? _initialCameraPosition;
//   String distanceInfo = "";

//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   bool _isMapReady = false;

//   @override
//   void initState() {
//     super.initState();
//     _initMap();
//   }

//   Future<void> _initMap() async {
//     await _loadCustomMarkers();
//     await _requestPermissionAndFetchLocation();
//     _addRandomShopMarkers();
//     setState(() {
//       _isMapReady = true;
//       distanceInfo = '';
//     });
//   }

//   Future<void> _loadCustomMarkers() async {
//     _currentMarkerIcon = await BitmapDescriptor.fromAssetImage(
//       const ImageConfiguration(devicePixelRatio: 2.5),
//       'assets/g_marker.png',
//     );

//     _shopMarkerIcon = await BitmapDescriptor.fromAssetImage(
//       const ImageConfiguration(devicePixelRatio: 2.5),
//       'assets/shop_icon_marker.png',
//     );
//   }

//   Future<void> _requestPermissionAndFetchLocation() async {
//     bool serviceEnabled = await location.serviceEnabled();
//     if (!serviceEnabled) {
//       serviceEnabled = await location.requestService();
//       if (!serviceEnabled) return;
//     }

//     var permissionGranted = await location.hasPermission();
//     if (permissionGranted == loc.PermissionStatus.denied) {
//       permissionGranted = await location.requestPermission();
//       if (permissionGranted != loc.PermissionStatus.granted) return;
//     }

//     final currentLocation = await location.getLocation();
//     _currentLatLng = LatLng(
//       currentLocation.latitude ?? 24.8607,
//       currentLocation.longitude ?? 67.0011,
//     );

//     _initialCameraPosition = CameraPosition(target: _currentLatLng!, zoom: 14);

//     if (_currentMarkerIcon != null) {
//       _markers.add(
//         Marker(
//           markerId: const MarkerId('current_location'),
//           position: _currentLatLng!,
//           icon: _currentMarkerIcon!,
//           infoWindow: const InfoWindow(title: 'Your Location'),
//         ),
//       );
//     }
//   }

//   void _addRandomShopMarkers() {
//     final List<LatLng> randomShops = [
//       const LatLng(24.8615, 67.0099),
//       const LatLng(24.8581, 67.0136),
//       const LatLng(24.8672, 67.0211),
//       const LatLng(24.8569, 67.0012),
//       const LatLng(24.8703, 67.0455),
//     ];

//     for (int i = 0; i < randomShops.length; i++) {
//       final shopId = 'shop_$i';
//       final shopLatLng = randomShops[i];

//       _markers.add(
//         Marker(
//           markerId: MarkerId(shopId),
//           position: shopLatLng,
//           icon: _shopMarkerIcon ?? BitmapDescriptor.defaultMarker,
//           infoWindow: InfoWindow(title: 'Location ${i + 1}'),
//           onTap: () {
//             _showTappedMarkerDistance(shopLatLng, 'Location ${i + 1}');
//           },
//         ),
//       );
//     }
//   }

//   void _showTappedMarkerDistance(LatLng target, String name) {
//     if (_currentLatLng == null) return;

//     double distanceInMeters = Geolocator.distanceBetween(
//       _currentLatLng!.latitude,
//       _currentLatLng!.longitude,
//       target.latitude,
//       target.longitude,
//     );

//     setState(() {
//       distanceInfo =
//           'Distance: ${(distanceInMeters / 1000).toStringAsFixed(2)} km (to $name)';
//     });
//   }

//   void _onMapCreated(GoogleMapController controller) {
//     _mapController = controller;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       drawer: CustomNavDrawer(),
//       body: Stack(
//         children: [
//           if (_isMapReady && _initialCameraPosition != null)
//             GoogleMap(
//               padding: const EdgeInsets.only(bottom: 60),
//               onMapCreated: _onMapCreated,
//               initialCameraPosition: _initialCameraPosition!,
//               mapType: MapType.normal,
//               markers: _markers,
//               myLocationButtonEnabled: false,
//               zoomControlsEnabled: false,
//             ),
//           Positioned(
//             top: 38,
//             left: 16,
//             child: DrawerMenuButton(scaffoldKey: _scaffoldKey),
//           ),
//           if (distanceInfo.isNotEmpty)
//             Positioned(
//               bottom: 70,
//               left: 16,
//               right: 16,
//               child: Container(
//                 padding: const EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   color: Colors.white70,
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Text(
//                   distanceInfo,
//                   style: const TextStyle(
//                       fontSize: 14, fontWeight: FontWeight.w500),
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }
