import 'package:attendence_app/Features/Reports/reports_view.dart';
import 'package:attendence_app/Features/marked_attendence/marked_attendence_offline.dart';
import 'package:attendence_app/Features/marked_attendence/marked_attendence_view.dart';
import 'package:attendence_app/Features/profile/profile_view.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  bool connectivity;
  HomeScreen({super.key, required this.connectivity});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    print("HOME VIEW ${widget.connectivity}");
    print("HOME VIEW ${widget.connectivity}");
    print("HOME VIEW ${widget.connectivity}");
    print("HOME VIEW ${widget.connectivity}");
    print("HOME VIEW ${widget.connectivity}");

    final List<Widget> screens = [
      widget.connectivity == true
          ? MarkedAttendenceView()
          : MarkedAttendenceOffline(),
      ReportsViewScreen(),
      ProfileView(),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavBarExact(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

class BottomNavBarExact extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNavBarExact({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  static const List<_NavItem> _items = [
    _NavItem('Attendence', "assets/attendance.png"),
    _NavItem('Reports', "assets/reports.png"),
    _NavItem('Profile', "assets/profile_icon.png"),
  ];

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(40),
      child: Container(
        height: 80,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(_items.length, (index) {
            final isSelected = index == currentIndex;
            final item = _items[index];
            final color =
                isSelected ? const Color(0xFF3B68FF) : const Color(0xFF47474F);

            return GestureDetector(
              onTap: () => onTap(index),
              behavior: HitTestBehavior.opaque,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    item.imageicon,
                    width: 27,
                    height: 27,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.label,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: color,
                      fontFamily: 'Satoshi',
                    ),
                  ),
                  const SizedBox(height: 4),
                  if (isSelected)
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: Color(0xFF3B68FF),
                        shape: BoxShape.circle,
                      ),
                    )
                  else
                    const SizedBox(height: 6),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}

class _NavItem {
  final String label;
  final String imageicon;
  const _NavItem(this.label, this.imageicon);
}
