import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

  void showTimeCardPopup(BuildContext context) {
    final DateTime checkInDateTime = DateTime(2025, 8, 7, 9, 0);
    final DateTime checkOutDateTime = DateTime(2025, 8, 7, 18, 0);

    final String checkInDate = DateFormat('MMM dd, yyyy').format(checkInDateTime);
    final String checkInTime = DateFormat('hh:mm a').format(checkInDateTime);
    final String checkOutDate = DateFormat('MMM dd, yyyy').format(checkOutDateTime);
    final String checkOutTime = DateFormat('hh:mm a').format(checkOutDateTime);

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Colors.white,
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Heading
                Text(
                  '🕒 Time Card',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 20),

                // Check-In Section
                Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.green),
                    const SizedBox(width: 10),
                    Text(
                      'Check-In',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const SizedBox(width: 32),
                    Text('Date: ', style: TextStyle(fontWeight: FontWeight.w500)),
                    Text(checkInDate),
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(width: 32),
                    Text('Time: ', style: TextStyle(fontWeight: FontWeight.w500)),
                    Text(checkInTime),
                  ],
                ),

                const SizedBox(height: 20),

                // Check-Out Section
                Row(
                  children: [
                    Icon(Icons.logout, color: Colors.redAccent),
                    const SizedBox(width: 10),
                    Text(
                      'Check-Out',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const SizedBox(width: 32),
                    Text('Date: ', style: TextStyle(fontWeight: FontWeight.w500)),
                    Text(checkOutDate),
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(width: 32),
                    Text('Time: ', style: TextStyle(fontWeight: FontWeight.w500)),
                    Text(checkOutTime),
                  ],
                ),

                const SizedBox(height: 25),

                // Close Button
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Close',style: TextStyle(color: Colors.white),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
