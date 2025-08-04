import 'package:attendence_app/Features/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import '../leave_request/leave_request_view.dart';

class CustomNavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final storage = GetStorage();
    var time = storage.read("checkin_time");
    var date = storage.read("checkin_date");
    return Padding(
      padding: const EdgeInsets.only(top: 65.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.88,
        child: Drawer(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFE7EFFE), Color(0xFFF8FAFF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: SafeArea(
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          "Hello, Test User",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),

                      SizedBox(height: 9),

                      Divider(thickness: 1, height: 1),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, top: 10),
                        child: Text(
                          "CHECK-IN at $time on $date.",
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xff323747),
                            fontWeight: FontWeight.w300,
                            fontFamily: 'Satoshi',
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Divider(thickness: 1, height: 1),

                      SizedBox(height: 9),
                      // Menu Items
                      Expanded(
                        child: ListView(
                          padding: EdgeInsets.zero,
                          children: [
                            _buildMenuItem(
                              "assets/home_icon.png",
                              'Home',
                              onTap: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        HomeScreen(connectivity: true),
                                  ),
                                );
                              },
                            ),
                            _buildMenuItem(
                              "assets/leave_request.png",
                              'Leave Request',
                              onTap: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        LeaveApplicationFormScreen(),
                                  ),
                                );
                              },
                            ),
                            _buildMenuItem(
                              "assets/change_password.png",
                              'Change Password',
                            ),
                            Divider(),
                            ListTile(
                              leading: Image.asset("assets/logout.png"),
                              // Icon(Icons.logout, color: Colors.redAccent),
                              title: Text(
                                'Logout',
                                style: TextStyle(
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                ),
                              ),
                              onTap: () {
                                //   logoutDialog(context);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    String icon,
    String title, {
    bool selected = false,
    VoidCallback? onTap,
  }) {
    return Container(
      color: selected ? Color(0xFFDDE8FF) : Colors.transparent,
      child: ListTile(
        leading: Image.asset(icon, height: 40, width: 40),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 17,
            color: Color(0xff323747),
            fontWeight: FontWeight.w400,
            fontFamily: 'Satoshi',
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
