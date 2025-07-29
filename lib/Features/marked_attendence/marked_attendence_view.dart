import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:geocoding/geocoding.dart';
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
  CameraPosition? _initialCameraPosition;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isMapReady = false;

  @override
  void initState() {
    super.initState();
    _initMap();
  }

  Future<void> _initMap() async {
    await _loadCustomMarker();
    await _requestPermissionAndFetchLocation();
    setState(() => _isMapReady = true);
  }

  Future<void> _loadCustomMarker() async {
    _customMarkerIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(devicePixelRatio: 2.5),
      'assets/g_marker.png',
    );
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

    final currentLatLng = LatLng(
      currentLocation.latitude ?? 30.3753,
      currentLocation.longitude ?? 69.3451,
    );

    _initialCameraPosition = CameraPosition(target: currentLatLng, zoom: 18);

    try {
      final placemarks = await placemarkFromCoordinates(
        currentLatLng.latitude,
        currentLatLng.longitude,
      );

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        final address =
            "${place.name}, ${place.street}, ${place.locality}, ${place.country}";
        _currentAddress = address;
      }
    } catch (e) {
      debugPrint("Error getting address: $e");
    }

    if (_customMarkerIcon != null) {
      _markers.add(
        Marker(
          markerId: const MarkerId('custom_marker'),
          position: currentLatLng,
          icon: _customMarkerIcon!,
          infoWindow: const InfoWindow(title: 'Your Location'),
        ),
      );
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomNavDrawer(),
      body: Stack(
        children: [
          if (_isMapReady && _initialCameraPosition != null)
            GoogleMap(
              padding: const EdgeInsets.only(bottom: 40),
              onMapCreated: _onMapCreated,
              initialCameraPosition: _initialCameraPosition!,
              mapType: MapType.normal,
              markers: _markers,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: true,
            )
          else
            const SizedBox(), 
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
