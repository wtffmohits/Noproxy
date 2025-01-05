import 'package:flutter/material.dart';
import 'package:noproxy/components/App_widgets/Home_widgets/calender.dart';
import 'package:noproxy/components/App_widgets/Home_widgets/checkin.dart';
import 'package:noproxy/components/App_widgets/Home_widgets/overview.dart';
import 'package:noproxy/widgets/Appbar/Appbar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60), child: TAppbar()),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                height: 1000,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(245, 245, 245, 1.000),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                padding: const EdgeInsets.all(20.0),
                child: const Column(
                  children: [
                    // overview section
                    Overview(),
                    SizedBox(height: 20),
                    // calender section
                    calender(),
                    SizedBox(height: 20),
                    // Checkin section for student upcomming lactures
                    Checkins(),
                    SizedBox(height: 20),
                    // upcoming lectures section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "'Upcomming lectures:)",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
