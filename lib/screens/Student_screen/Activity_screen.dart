import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class AttendanceData {
  final String month;
  final int totalDays;
  final int presentDays;
  final int absentDays;

  AttendanceData({
    required this.month,
    required this.totalDays,
    required this.presentDays,
    required this.absentDays,
  });
}
class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  final List<AttendanceData> attendanceData = [
    // Sample data
    AttendanceData(month: 'January', totalDays: 31, presentDays: 25, absentDays: 6),
    AttendanceData(month: 'February', totalDays: 28, presentDays: 22, absentDays: 6),
    // ... more months
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance'),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Color.fromRGBO(245,245,245,1.000),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: ListView.builder(
          itemCount: attendanceData.length, // Uncomment this line
          itemBuilder: (context, index) {
            final data = attendanceData[index];
            return ListTile(
              title: Text(data.month),
              subtitle: _buildPieChart(data.presentDays, data.absentDays),
            );
          },
        ),
      ),
    );
  }

  Widget _buildPieChart(int presentDays, int absentDays) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: PieChart(
          PieChartData(
            sections: [
              PieChartSectionData(
                color: Colors.green,
                value: presentDays.toDouble(),
                title: 'Present',
                radius: 40,
                titleStyle: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              PieChartSectionData(
                color: Colors.red,
                value: absentDays.toDouble(),
                title: 'Absent',
                radius: 40,
                titleStyle: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}