import 'package:flutter/material.dart';
import 'package:noproxy/screens/Signin/Student_login/signin_screen.dart';
import 'package:noproxy/screens/Signin/Teacher_login/signin_screen.dart';

class LogiDest extends StatelessWidget {
  const LogiDest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 35),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Select Login',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 50.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildLoginButton(
                        context,
                        'assets/images/student.png',
                        'Student',
                        // Navigate to student login screen
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterPage(),
                          ),
                        ),
                      ),
                      _buildLoginButton(
                        context,
                        'assets/images/teach.png',
                        'Teacher',
                        // Navigate to parent login screen
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterPages(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildLoginButton(BuildContext context, String iconPath, String label,
    VoidCallback onPressed) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.blue.shade50,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      minimumSize: const Size(150, 150),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          iconPath,
          width: 50,
          height: 50,
        ),
        const SizedBox(height: 10),
        Text(
          label,
          style: const TextStyle(
              fontSize: 18.0, color: Color.fromARGB(255, 0, 0, 0)),
        ),
      ],
    ),
  );
}
