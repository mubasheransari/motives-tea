import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

class MarkedAttendenceOffline extends StatefulWidget {
  const MarkedAttendenceOffline({super.key});

  @override
  State<MarkedAttendenceOffline> createState() => _MarkedAttendenceOfflineState();
}

class _MarkedAttendenceOfflineState extends State<MarkedAttendenceOffline> {
  double? latitude;
  double? longitude;
  String? currentDate;
  String? currentTime;
  String statusMessage = 'Fetching location...';

  @override
  void initState() {
    super.initState();
    _getLocationAndTime();
  }

  Future<void> _getLocationAndTime() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          statusMessage = 'Location services are disabled.';
        });
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            statusMessage = 'Location permissions are denied.';
          });
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() {
          statusMessage = 'Location permissions are permanently denied.';
        });
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        latitude = position.latitude;
        longitude = position.longitude;

        final now = DateTime.now();
        currentDate = DateFormat('yyyy-MM-dd').format(now);
        currentTime = DateFormat('hh:mm a').format(now);
        

        statusMessage = 'Location acquired successfully.';
      });
    } catch (e) {
      setState(() {
        statusMessage = 'Error fetching location: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Offline Attendance")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(statusMessage, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),

            if (latitude != null && longitude != null) ...[
              Text("Latitude: $latitude", style: const TextStyle(fontSize: 18)),
              Text("Longitude: $longitude", style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 10),
              Text("Date: $currentDate", style: const TextStyle(fontSize: 18)),
              Text("Time: $currentTime", style: const TextStyle(fontSize: 18)),
            ],
          ],
        ),
      ),
    );
  }
}
