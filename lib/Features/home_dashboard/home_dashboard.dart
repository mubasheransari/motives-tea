import 'package:attendence_app/Features/punch_order/punch_order.dart';
import 'package:attendence_app/Features/routes/route_view.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class HomeDashboard extends StatefulWidget {
  @override
  _HomeDashboardState createState() => _HomeDashboardState();
}

class _HomeDashboardState extends State<HomeDashboard> {
  double circularValue = 4.55; // Dynamic circular value
  int redPercent = 5;
  int yellowPercent = 15;
  int greenPercent = 80;

  List<String> days = ['SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT'];
  int selectedIndex = 3; // Default to Wednesday

  List<FlSpot> graphPoints = [
    FlSpot(0, 2.5),
    FlSpot(1, 3.0),
    FlSpot(2, 3.8),
    FlSpot(3, 4.2),
    FlSpot(4, 3.9),
    FlSpot(5, 4.5),
    FlSpot(6, 4.1),
  ];

  final List<Map<String, dynamic>> menuFeatures = [
    {'icon': Icons.lock_clock, 'label': 'Time\nCard'},
    {'icon': Icons.route, 'label': "Today's\nRoute"},
    {'icon': Icons.shopping_cart, 'label': 'Punch\nOrder'},
    {'icon': Icons.cloud_download, 'label': 'Sync\nIn'},
  ];

  final List<Map<String, dynamic>> menuFeatures1 = [
    {'icon': Icons.cloud_upload, 'label': 'Sync\nIn'},
    {'icon': Icons.reviews, 'label': "Shop\nOwner\nReview"},
    {'icon': Icons.event_busy, 'label': "Leave\nRequest"},
    {'icon': Icons.event_busy, 'label': "Leave\nRequest"},
  ];

  Color getProgressColor(double percent) {
    if (percent < 0.25) {
      return Colors.red;
    } else if (percent < 0.5) {
      return Colors.orange;
    } else if (percent < 0.75) {
      return Colors.yellow;
    } else {
      return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Routes",
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          _statusDot(Colors.green, "Planned"),
                          _statusDot(Colors.orange, "Actual"),
                        ],
                      ),
                      Row(
                        children: [
                          _statusDot(Colors.yellow, "Productive"),
                          _statusDot(Colors.red, "Remaining"),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 150,
                    width: 150,
                    child: SfRadialGauge(
                      axes: <RadialAxis>[
                        RadialAxis(
                          startAngle: 180,
                          endAngle: 180,
                          minimum: 0,
                          maximum: 100,

                          showTicks: false,
                          showLabels: false,
                          ranges: <GaugeRange>[
                            GaugeRange(
                              label: 'Planned (3)',
                              labelStyle: GaugeTextStyle(
                                fontSize: 10,
                                color: Colors.white,
                              ),
                              startValue: 0,
                              endValue: 25,
                              color: Colors.green,
                              startWidth: 29,
                              endWidth: 29,
                            ),
                            GaugeRange(
                              label: 'Actual (1)',
                              labelStyle: GaugeTextStyle(
                                fontSize: 10,
                                color: Colors.white,
                              ),
                              startValue: 25,
                              endValue: 50,
                              color: Colors.orange,
                              startWidth: 29,
                              endWidth: 29,
                            ),
                            GaugeRange(
                              label: 'Productive (1)',
                              labelStyle: GaugeTextStyle(
                                fontSize: 10,
                                color: Colors.white,
                              ),
                              startValue: 50,
                              endValue: 75,
                              color: Colors.yellow,
                              startWidth: 29,
                              endWidth: 29,
                            ),
                            GaugeRange(
                              label: 'Remaining (1)',
                              labelStyle: GaugeTextStyle(
                                fontSize: 10,
                                color: Colors.white,
                              ),
                              startValue: 75,
                              endValue: 100,
                              color: Colors.red,
                              startWidth: 29,
                              endWidth: 29,
                            ),
                          ],
                         
                          annotations: <GaugeAnnotation>[
                            GaugeAnnotation(
                              widget: Text(
                                "Today's\nRoute",
                                textAlign: TextAlign.center,
                              ),
                              angle: 0, 
                              positionFactor: 0, 
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  /*   CircularPercentIndicator(
  radius: 50.0,
  lineWidth: 8.0,
  percent: (circularValue / 10).clamp(0.0, 1.0),
  center: Text(
    "Today's\nRoute",
    style: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
  ),
  progressColor: getProgressColor((circularValue / 10).clamp(0.0, 1.0)),
)*/

                  // CircularPercentIndicator(
                  //   radius: 50.0,
                  //   lineWidth: 8.0,
                  //   percent: (circularValue / 10).clamp(0.0, 1.0),
                  //   center: Text(
                  //     "Today's\nRoute",
                  //     style: TextStyle(
                  //       fontSize: 14,
                  //       fontWeight: FontWeight.w500,
                  //     ),
                  //   ),
                  //   progressColor: Colors.blue,
                  // ),
                ],
              ),
              SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    flex: redPercent,
                    child: Container(height: 10, color: Colors.red),
                  ),
                  Expanded(
                    flex: yellowPercent,
                    child: Container(height: 10, color: Colors.orange),
                  ),
                  Expanded(
                    flex: greenPercent,
                    child: Container(height: 10, color: Colors.green),
                  ),
                ],
              ),
              SizedBox(height: 12),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(days.length, (index) {
                  return GestureDetector(
                    onTap: () => setState(() => selectedIndex = index),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: selectedIndex == index
                            ? Colors.blue
                            : Colors.transparent,
                      ),
                      child: Column(
                        children: [
                          Text(
                            days[index],
                            style: TextStyle(
                              color: selectedIndex == index
                                  ? Colors.white
                                  : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            DateFormat('d').format(
                              DateTime.now().subtract(
                                Duration(days: 3 - index),
                              ),
                            ),
                            style: TextStyle(
                              fontSize: 12,
                              color: selectedIndex == index
                                  ? Colors.white
                                  : Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
              SizedBox(height: 24),

              Container(
                child: SizedBox(
                  height: 160,
                  child: LineChart(
                    LineChartData(
                      gridData: FlGridData(show: true),
                      titlesData: FlTitlesData(show: false),
                      borderData: FlBorderData(show: false),
                      lineBarsData: [
                        LineChartBarData(
                          spots: graphPoints,
                          isCurved: true,
                          color: Colors.blue,
                          barWidth: 3,
                          dotData: FlDotData(show: true),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "LAST ACTION PERFORMED : CHECK-IN",
                    style: TextStyle(color: Colors.blue),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: 60,
                    width: MediaQuery.of(context).size.width *0.28,
                    child: Row(
                      children: [
                        SizedBox(width: 5,),
                        Center(child: Icon(Icons.gps_fixed, size: 25,color: Colors.blue,)),
                         SizedBox(width: 3,),
                        Center(
                          child: Text(
                            "Targets",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  ),
                     Container(
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: 60,
                    width: MediaQuery.of(context).size.width *0.31,
                    child: Row(
                      children: [
                        SizedBox(width: 5,),
                        Center(child: Icon(Icons.show_chart, size: 25,color: Colors.blue,)),
                         SizedBox(width: 3,),
                        Center(
                          child: Text(
                            "Sales Tons",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  ),
                         Container(
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: 60,
                    width: MediaQuery.of(context).size.width *0.28,
                    child: Row(
                      children: [
                        SizedBox(width: 5,),
                        Center(child: Icon(Icons.percent, size: 22,color: Colors.blue,)),
                         SizedBox(width: 3,),
                        Center(
                          child: Text(
                            "Ach Per",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  ),
                 
                ],
              ),
              Card(
                color: Colors.white,
                elevation: 0,
                margin: const EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: SizedBox(
                  height: 120,
                  width: MediaQuery.of(context).size.width * 0.95,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: menuFeatures.length,
                    separatorBuilder: (_, __) => SizedBox(
                      width: MediaQuery.of(context).size.width * 0.14,
                    ),
                    itemBuilder: (context, index) {
                      final features = menuFeatures[index];
                      print("OPTIONs CLICKED ${features['label']}");
                      return InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        onTap: () {
                          print("OPTIONs CLICKED ${features['label']}");
                          if (features['label'] == "Time\nCard") {
                            print("Mubashetr");
                            print("Mubashetr");
                            print("Mubashetr");
                          } else if (features['label'] == "Today's\nRoute") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RouteGoogleMap(),
                              ),
                            );
                          } else if (features['label'] == "Punch\nOrder") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PunchOrderView(),
                              ),
                            );
                          }
                        },
                        child: Column(
                          //  mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.blue.withOpacity(0.1),
                              child: Icon(features['icon'], color: Colors.blue),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              features['label'],
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              Card(
                color: Colors.white,
                elevation: 0,
                margin: const EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: SizedBox(
                  height: 120,
                  width: MediaQuery.of(context).size.width * 0.95,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: menuFeatures1.length,
                    separatorBuilder: (_, __) => SizedBox(
                      width: MediaQuery.of(context).size.width * 0.14,
                    ),
                    itemBuilder: (context, index) {
                      final features = menuFeatures1[index];
                      print("OPTION CLICKED $features");
                      return Column(
                        //  mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.blue.withOpacity(0.1),
                            child: Icon(features['icon'], color: Colors.blue),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            features['label'],
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statusDot(Color color, String label) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Row(
        children: [
          CircleAvatar(radius: 4, backgroundColor: color),
          SizedBox(width: 4),
          Text(label, style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
