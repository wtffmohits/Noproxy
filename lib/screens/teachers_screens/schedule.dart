import 'package:flutter/material.dart';
import 'package:noproxy/widgets/teacher/input_field.dart';
import 'package:intl/intl.dart';

class Scheduling extends StatefulWidget {
  const Scheduling({super.key});

  @override
  State<Scheduling> createState() => _SchedulingState();
}

class _SchedulingState extends State<Scheduling> {
  DateTime selectedDate = DateTime.now();
  String endTime = '9:30 PM';
  String startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  int? reminderMinutes;
  int selectedColor = 0;
  String selectedRepeat = 'None'; // Initialize with default value

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Schedule'),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Add Schedule",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              MyInputField(hint: "Enter your Title", title: "Title"),
              MyInputField(hint: "Enter your Note", title: "Note"),
              MyInputField(
                  hint: DateFormat.yMd().format(selectedDate),
                  title: "Date",
                  widget: IconButton(
                      icon: Icon(Icons.calendar_today),
                      onPressed: () {
                        _getDateFormUser();
                      })),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: MyInputField(
                        hint: startTime,
                        title: "Start Time",
                        widget: IconButton(
                          icon: Icon(Icons.access_time),
                          onPressed: () {
                            _getTimeFormUser();
                          },
                        )),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: MyInputField(
                      hint: endTime,
                      title: "End Time",
                      widget: IconButton(
                        icon: Icon(Icons.access_time),
                        onPressed: () {
                          _getTimeFormUser();
                        },
                      ),
                    ),
                  ),
                ],
              ),
              MyInputField(
                hint: reminderMinutes != null
                    ? reminderMinutes.toString() + " minutes early"
                    : "Select Reminder",
                title: "Reminder",
                widget: DropdownButton<int>(
                  icon: Icon(Icons.keyboard_arrow_down),
                  items: [
                    DropdownMenuItem(
                      child: Text("5 minutes early"),
                      value: 5,
                    ),
                    DropdownMenuItem(
                      child: Text("10 minutes early"),
                      value: 10,
                    ),
                    DropdownMenuItem(
                      child: Text("15 minutes early"),
                      value: 15,
                    ),
                    DropdownMenuItem(
                      child: Text("20 minutes early"),
                      value: 20,
                    ),
                  ],
                  onChanged: (int? newValue) {
                    setState(() {
                      reminderMinutes = newValue;
                    });
                  },
                ),
              ),
              MyInputField(
                hint: selectedRepeat, // Display selected repeat option
                title: "Repeat",
                widget: DropdownButton<String>(
                  icon: Icon(Icons.keyboard_arrow_down),
                  items: [
                    DropdownMenuItem(
                      child: Text("None"),
                      value: 'None',
                    ),
                    DropdownMenuItem(
                      child: Text("Daily"),
                      value: 'Daily',
                    ),
                    DropdownMenuItem(
                      child: Text("Weekly"),
                      value: 'Weekly',
                    ),
                    DropdownMenuItem(
                      child: Text("Monthly"),
                      value: 'Monthly',
                    ),
                  ],
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedRepeat = newValue!;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [_colorSelectedIndex()],
                // Button to save the schedule
              ),
            ],
          ),
        ),
      ),
    );
  }

  _getDateFormUser() async {
    DateTime? _pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );
    if (_pickedDate != null) {
      setState(() {
        selectedDate = _pickedDate;
      });
    } else {
      print("It is null");
    }
  }

  _getTimeFormUser() async {
    TimeOfDay? _time =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (_time != null) {
      setState(() {
        startTime = _time.format(context);
      });
    }
  }

  _colorSelectedIndex() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Color",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 8,
        ),
        Wrap(
          children: List<Widget>.generate(
            3,
            (int index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedColor = index;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: index == 0
                        ? Colors.red
                        : index == 1
                            ? Colors.blue
                            : Colors.green,
                    child: selectedColor == index
                        ? Icon(
                            Icons.done,
                            color: Colors.white,
                            size: 16,
                          )
                        : Container(),
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
