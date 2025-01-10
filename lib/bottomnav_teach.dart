import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:noproxy/screens/Student_screen/Attendance_screen.dart';
import 'package:noproxy/screens/Student_screen/Profile_screen.dart';
import 'package:noproxy/screens/Student_screen/home_screen.dart';
import 'package:noproxy/screens/teachers_screens/schedule.dart';

class NavigationMenuet extends StatelessWidget {
  const NavigationMenuet({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    return Scaffold(
        bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(
              indicatorColor: Colors.blue,
              labelTextStyle: WidgetStateProperty.all(
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.w500))),
          child: Obx(
            () => NavigationBar(
              height: 80,
              elevation: 0,
              selectedIndex: controller.selectedIndex.value,
              onDestinationSelected: (index) =>
                  controller.selectedIndex.value = index,
              destinations: const [
                NavigationDestination(
                    icon: Icon(
                      Iconsax.home,
                      size: 20,
                    ),
                    label: 'Home'),
                NavigationDestination(
                    icon: Icon(
                      Icons.check_circle,
                      size: 20,
                    ),
                    label: 'Attend'),
                NavigationDestination(
                    icon: Icon(
                      Iconsax.activity,
                      size: 20,
                    ),
                    label: 'Schedule'),
                NavigationDestination(
                    icon: Icon(
                      Iconsax.user,
                      size: 20,
                    ),
                    label: 'Profile'),
              ],
            ),
          ),
        ),
        body: Obx(
          () => controller.screens[controller.selectedIndex.value],
        ));
  }
}

class NavigationController extends GetxController {
  final RxInt selectedIndex = 0.obs;

  final screens = [
    const HomePage(),
    const QrScanScreen(),
    const Scheduling(),
    const ProfileScreen(),
  ];
}
