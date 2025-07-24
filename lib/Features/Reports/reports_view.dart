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
      final randomHour = 7 + random.nextInt(3); // between 7 to 9 AM
      final randomMinute = random.nextInt(60);
      final randomSecond = random.nextInt(60);

      final formattedDate = DateFormat('yyyy-MM-dd').format(date);
      final formattedTime = DateFormat('HH:mm:ss').format(
        DateTime(date.year, date.month, date.day, randomHour, randomMinute,
            randomSecond),
      );

      _checkinData.add({
        "date": formattedDate,
        "checkin_time": formattedTime,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      appbartitle: 'Monthly Report',
      isAppBarContentRequired: true,
      isDrawerRequired: true,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView.builder(
          itemCount: _checkinData.length,
          itemBuilder: (context, index) {
            final entry = _checkinData[index];
            return Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.indigo,
                  child: const Icon(Icons.access_time, color: Colors.white),
                ),
                title: Text(
                  "Date: ${entry['date']}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  "Check-in Time: ${entry['checkin_time']}",
                  style: const TextStyle(fontSize: 16),
                ),
                trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
              ),
            );
          },
        ),
      ),
    );
  }
}
