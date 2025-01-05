import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class AttendanceChart extends StatefulWidget {
  final Map<String, Map<String, int>> attendanceData;

  const AttendanceChart({super.key, required this.attendanceData});

  @override
  _AttendanceChartState createState() => _AttendanceChartState();
}

class _AttendanceChartState extends State<AttendanceChart> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200, // Adjust height as needed
      width: 200, // Adjust width as needed
      child: PieChart(
        PieChartData(
          sections: _buildPieChartSections(widget.attendanceData),
          centerSpaceRadius: 0,
          startDegreeOffset: -90,
        ),
      ),
    );
  }

  List<PieChartSectionData> _buildPieChartSections(
      Map<String, Map<String, int>> attendanceData) {
    List<PieChartSectionData> sections = [];

    attendanceData.forEach((month, days) {
      sections.add(
        PieChartSectionData(
          color: Colors.green, 
          value: days['present']!.toDouble(),
          title: 'Present',
          radius: 40,
          titleStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      );

      sections.add(
        PieChartSectionData(
          color: Colors.red,
          value: days['absent']!.toDouble(),
          title: 'Absent',
          radius: 40,
          titleStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      );
    });

    return sections;
  }
}

// Example usage:
Map<String, Map<String, int>> sampleAttendanceData = {
  'January': {'present': 20, 'absent': 5},
  'February': {'present': 25, 'absent': 3},
  // ... add more months
};

// In your main widget:
// AttendanceChart(attendanceData: sampleAttendanceData)