import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

  void showTimeCardPopup(BuildContext context) {
    final DateTime checkInDateTime = DateTime(2025, 8, 7, 9, 0);
    final DateTime checkOutDateTime = DateTime(2025, 8, 7, 18, 0);

    final String checkInDate = DateFormat('MMM dd, yyyy').format(checkInDateTime);
    final String checkInTime = DateFormat('hh:mm a').format(checkInDateTime);
    final String checkOutDate = DateFormat('MMM dd, yyyy').format(checkOutDateTime);
    final String checkOutTime = DateFormat('hh:mm a').format(checkOutDateTime);

        final storage = GetStorage();
  var time =  storage.read("checkin_time");
   var date= storage.read("checkin_date");

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
                Text(
                  '🕒 Time Card',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 20),

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
                    Text(date),
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(width: 32),
                    Text('Time: ', style: TextStyle(fontWeight: FontWeight.w500)),
                    Text(time),
                  ],
                ),

                const SizedBox(height: 20),

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
//i just want a checkin time that i get from get storage i dont have any problem with this i just want to modify according to that condition that i initially want checkin time only and End Route Button and when i click End Route it shows checkout time also and close button shows