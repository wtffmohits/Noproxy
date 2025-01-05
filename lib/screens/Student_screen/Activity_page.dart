import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:noproxy/screens/Student_screen/Activity_screen.dart';

class Activitys extends StatefulWidget {
  // final Map<String, Map<String, int>> attendanceData;
  final List<AttendanceData> attendanceData;

  const Activitys({super.key, required this.attendanceData});

  @override
  State<Activitys> createState() => _ActivitysState();
}

class _ActivitysState extends State<Activitys> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: const Text('Activity', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(245, 245, 245, 1.000),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          //     child: PieChart(
          //    PieChartData(
          //      sections: _buildPieChartSections(widget.attendanceData as Map<String, Map<String, int>>),
          //      centerSpaceRadius: 0,
          //      startDegreeOffset: -90,
          //    ),
          // ),
        ),
      ),
    );
  }
}

//  List<PieChartSectionData> _buildPieChartSections(
//       Map<String, Map<String, int>> attendanceData) {
//     List<PieChartSectionData> sections = [];

//     attendanceData.forEach((month, days) {
//       sections.add(
//         PieChartSectionData(
//           color: Colors.green, 
//           value: days['present']!.toDouble(),
//           title: 'Present',
//           radius: 40,
//           titleStyle: const TextStyle(
//             fontSize: 12,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//       );

//       sections.add(
//         PieChartSectionData(
//           color: Colors.red,
//           value: days['absent']!.toDouble(),
//           title: 'Absent',
//           radius: 40,
//           titleStyle: const TextStyle(
//             fontSize: 12,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//       );
//     });

//     return sections;
//   }


// // Example usage:
// Map<String, Map<String, int>> sampleAttendanceData = {
//   'January': {'present': 20, 'absent': 5},
//   'February': {'present': 25, 'absent': 3},
//   // ... add more months
// };


// // In your main widget (e.g., MaterialApp) or where you're using Activitys:

