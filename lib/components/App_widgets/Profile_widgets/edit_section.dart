
import 'package:flutter/material.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({super.key});

  @override
  _ProfileEditPageState createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: const Text('Edit Profile'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(245,245,245,1.000),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    // Profile Picture
                    const CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage('assets/images/profile_pic.png'), // Replace with your image path
                    ),
                    const SizedBox(height: 20),
                    buildtext("Full Name","Mohit Singh"),
                    buildtext("Email","xyz@gmail.com"),
                    buildtext("Contact number","123-456-7890"),
                    const SizedBox(height: 20),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Flexible(
                            child: Text(
                              "Collage :",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "Collage Name like TSDC Thakur Collage",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis, // Add ellipsis to handle long text
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header Section
                          _buildHeaderSection(),
                         
                        ],
                      ),
                    ),
                  ],
                ),
                ),
              ),
            ),
        ),
      );
  }

  Padding buildtext(String labletext, String placeholder) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0),
      child: TextField(
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(bottom: 3),
                      labelText: labletext,
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: placeholder,
                      hintStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w400
                      )
                    ),
                  ),
    );
  }
}


 Widget _buildHeaderSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailRow('Course', 'BSC IT'),
        const SizedBox(height: 5),
        _buildDetailRow('Roll No.', '50'),
        const SizedBox(height: 5),
        _buildDetailRow('Year', '3'),
        const SizedBox(height: 5),
        _buildDetailRow('Semester', '6'),
        const SizedBox(height: 5),
        _buildDetailRow('Division', 'A'),
        const SizedBox(height: 5),
        _buildSubjectDetailsSection(),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$label : ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value),
        ],
      ),
    );
  }

  Widget _buildSubjectDetailsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Subjects:', 
          style: TextStyle(
         
          fontWeight: FontWeight.w600,
          )
        ),
        const SizedBox(height: 5),
        _buildSubjectItem('1. Android Programming Practical Batch A'),
        _buildSubjectItem('2. Business Intelligence and Data Analytics'),
        _buildSubjectItem('3. Business Intelligence and Data Analytics Batch A'),
        _buildSubjectItem('4. Fundamentals of GIS Batch A'),
        _buildSubjectItem('5. Information Security'),
      ],
    );
  }

  Widget _buildSubjectItem(String subject) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text('- $subject'),
    );
  }

  double _calculateFontSize(BuildContext context, double baseFontSize) {
    final double screenRatio = MediaQuery.of(context).size.width / MediaQuery.of(context).size.height;
    // Adjust the multiplier and threshold based on your desired behavior
    if (screenRatio > 1.2) { // Consider landscape mode with a wider screen
      return baseFontSize;
    } else {
      return baseFontSize * 0.8; // Reduce font size slightly for portrait mode
    }
  }