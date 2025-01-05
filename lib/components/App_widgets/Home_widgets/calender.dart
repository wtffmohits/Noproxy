import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';

class calender extends StatelessWidget {
  const calender({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        // color: Colors.black,
      ),
      child: DatePicker(
        DateTime.now(),
        height: 90,
        width: 60,
        initialSelectedDate: DateTime.now(),
        selectionColor: Colors.blueAccent,
        dateTextStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromARGB(255, 0, 0, 0),
          fontWeight: FontWeight.bold,
        ),
        dayTextStyle: const TextStyle(
          fontSize: 10,
          // color: Colors.grey,
          // fontWeight: FontWeight.bold,
        ),
        monthTextStyle: const TextStyle(
          fontSize: 10,
          // color: Colors.grey,
          // fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
