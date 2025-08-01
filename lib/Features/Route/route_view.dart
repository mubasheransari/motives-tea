import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import '../NavBar/custom_navbar.dart';
import '../NavBar/drawer_menu_button.dart';

class RouteGoogleMap extends StatefulWidget {
  const RouteGoogleMap({super.key});

  @override
  State<RouteGoogleMap> createState() => _RouteGoogleMapState();
}

class _RouteGoogleMapState extends State<RouteGoogleMap> {
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
    _addRandomShopMarkers();
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

    _shopMarkerIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(devicePixelRatio: 2.5),
      'assets/shop_icon_marker.png',
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

  void _addRandomShopMarkers() {
    final List<LatLng> randomShops = [
      const LatLng(24.8615, 67.0099),
      const LatLng(24.8581, 67.0136),
      const LatLng(24.8672, 67.0211),
      const LatLng(24.8569, 67.0012),
      const LatLng(24.8703, 67.0455),
    ];

    for (int i = 0; i < randomShops.length; i++) {
      final shopId = 'shop_$i';
      final shopLatLng = randomShops[i];

      _markers.add(
        Marker(
          markerId: MarkerId(shopId),
          position: shopLatLng,
          icon: _shopMarkerIcon ?? BitmapDescriptor.defaultMarker,
          infoWindow: InfoWindow(title: 'Location ${i + 1}'),
          onTap: () {
            _showTappedMarkerDistance(shopLatLng, 'Location ${i + 1}');
          },
        ),
      );
    }
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomNavDrawer(),
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
          Positioned(
            top: 38,
            left: 16,
            child: DrawerMenuButton(scaffoldKey: _scaffoldKey),
          ),
          if (distanceInfo.isNotEmpty)
            Positioned(
              bottom: 70,
              left: 16,
              right: 16,
              child: Container(
                padding: const EdgeInsets.all(12),
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
        ],
      ),
    );
  }
}
