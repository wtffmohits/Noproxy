import 'package:flutter/material.dart';

class ProName extends StatelessWidget {
  const ProName({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: _calculateAvatarRadius(context),
            backgroundImage: const AssetImage("assets/images/mohits.jpeg"), // Replace with your image path
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Mohit Singh",
                  style: TextStyle(
                    fontSize: _calculateFontSize(context, 20),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Thakur Shyamnarayan Degree Collage",
                  style: TextStyle(
                    fontSize: _calculateFontSize(context, 18),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  double _calculateAvatarRadius(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    // Adjust the multiplier based on your desired behavior
    return screenWidth * 0.1; // Example: 10% of screen width
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
}