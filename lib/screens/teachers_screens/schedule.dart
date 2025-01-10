import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:noproxy/components/Buttons/button.dart';
import 'package:noproxy/components/controller/task_controller.dart';
import 'package:noproxy/models/task.dart';
import 'package:noproxy/widgets/teacher/input_field.dart';
import 'package:intl/intl.dart';

class Scheduling extends StatefulWidget {
  const Scheduling({super.key});

  @override
  State<Scheduling> createState() => _SchedulingState();
}

class _SchedulingState extends State<Scheduling> {
  final TaskController taskController = Get.put(TaskController());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  String endTime = '9:30 PM';
  String startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  int? reminderMinutes = 5;
  int selectedColor = 0;
  String selectedRepeat = 'None'; // Initialize with default value

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Schedule'),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.only(left: 20, right: 20),
            decoration: BoxDecoration(
              color: Color.fromRGBO(245, 245, 245, 1.000),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Add Schedule",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                MyInputField(
                  hint: "Enter your Title",
                  title: "Title",
                  controller: _titleController,
                ),
                MyInputField(
                  hint: "Enter your Note",
                  title: "Note",
                  controller: _noteController,
                ),
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
                      ? "$reminderMinutes minutes early"
                      : "Select Reminder",
                  title: "Reminder",
                  widget: DropdownButton<int>(
                    icon: Icon(Icons.keyboard_arrow_down),
                    items: [
                      DropdownMenuItem(
                        value: 5,
                        child: Text("5 minutes early"),
                      ),
                      DropdownMenuItem(
                        value: 10,
                        child: Text("10 minutes early"),
                      ),
                      DropdownMenuItem(
                        value: 15,
                        child: Text("15 minutes early"),
                      ),
                      DropdownMenuItem(
                        value: 20,
                        child: Text("20 minutes early"),
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
                        value: 'None',
                        child: Text("None"),
                      ),
                      DropdownMenuItem(
                        value: 'Daily',
                        child: Text("Daily"),
                      ),
                      DropdownMenuItem(
                        value: 'Weekly',
                        child: Text("Weekly"),
                      ),
                      DropdownMenuItem(
                        value: 'Monthly',
                        child: Text("Monthly"),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _colorSelectedIndex(),
                    BlueButton(lable: "Schedule", onTap: () => _validateDate())
                  ],
                  // Button to save the schedule
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _validateDate() {
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      _addTaskToDb();
      Get.back();
    } else if (_titleController.text.isEmpty || _noteController.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Please fill all the fields",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        icon: Icon(Icons.warning_amber_rounded),
      );
      // Show error message
    }
  }

  _getDateFormUser() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );
    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    } else {
      print("It is null");
    }
  }

  _getTimeFormUser() async {
    TimeOfDay? time =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (time != null) {
      setState(() {
        startTime = time.format(context);
      });
    }
  }

  _addTaskToDb() async {
    int value = await taskController.addtask(
        task: Task(
      note: _noteController.text,
      title: _titleController.text,
      date: DateFormat.yMd().format(selectedDate),
      startTime: startTime,
      endTime: endTime,
      reminderMinutes: reminderMinutes = 0,
      repeat: selectedRepeat,
      color: selectedColor,
      isCompleted: 0,
      id: null,
    ));
    print("My id is $value");
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
