import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../widgets/customScaffoldWidget.dart';


class ReportsViewScreen extends StatefulWidget {
  const ReportsViewScreen({super.key});

  @override
  State<ReportsViewScreen> createState() => _ReportsViewScreenState();
}

class _ReportsViewScreenState extends State<ReportsViewScreen> {
  final List<Map<String, String>> _checkinData = [];

  @override
  void initState() {
    super.initState();
    _generateMockData();
  }

  void _generateMockData() {
    final now = DateTime.now();
    final random = Random();

    for (int i = 0; i < 30; i++) {
      final date = now.subtract(Duration(days: i));

      final checkInHour = 7 + random.nextInt(3);
      final checkInMinute = random.nextInt(60);
      final checkInSecond = random.nextInt(60);

      final checkIn = DateTime(
        date.year,
        date.month,
        date.day,
        checkInHour,
        checkInMinute,
        checkInSecond,
      );

      final randomHours = 6 + random.nextInt(4); 
      final randomMinutes = random.nextInt(60);
      final randomSeconds = random.nextInt(60);

      final checkOut = checkIn.add(Duration(
        hours: randomHours,
        minutes: randomMinutes,
        seconds: randomSeconds,
      ));

      final totalDuration = checkOut.difference(checkIn);

      _checkinData.add({
        "date": DateFormat('yyyy-MM-dd').format(date),
        "checkin_time": DateFormat('HH:mm:ss').format(checkIn),
        "checkout_time": DateFormat('HH:mm:ss').format(checkOut),
        "total_time": _formatDuration(totalDuration),
      });
    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return "${twoDigits(duration.inHours)}:"
        "${twoDigits(duration.inMinutes.remainder(60))}:"
        "${twoDigits(duration.inSeconds.remainder(60))}";
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      isDrawerRequired: true,
    appbartitle: 'Report/History',
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView.builder(
          itemCount: _checkinData.length,
          itemBuilder: (context, index) {
            final entry = _checkinData[index];
            return Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.calendar_today, color: Colors.indigo),
                        const SizedBox(width: 8),
                        Text(
                          "Date: ${entry['date']}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.login, color: Colors.green),
                        const SizedBox(width: 8),
                        Text("Check-in: ${entry['checkin_time']}"),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.logout, color: Colors.red),
                        const SizedBox(width: 8),
                        Text("Check-out: ${entry['checkout_time']}"),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.access_time_filled, color: Colors.blueGrey),
                        const SizedBox(width: 8),
                        Text("Total Time: ${entry['total_time']}"),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
