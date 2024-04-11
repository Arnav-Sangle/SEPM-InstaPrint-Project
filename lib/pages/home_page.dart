import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome to InstaPrint!'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Custom Image
            Image.asset(
              'assets/images/instaPrintLogo.png', // Replace this with the path to your custom image
              width: 200,
              height: 200,
            ),
            SizedBox(height: 50),
            // Section 1: Create print request
            ElevatedButton(
              onPressed: () {
                // Navigate to create print request page
              },
              child: Text('Create Print Request'),
            ),
            SizedBox(height: 20),
            // Section 2: Review previous requests
            ElevatedButton(
              onPressed: () {
                // Navigate to review previous requests page
              },
              child: Text('Review Previous Requests'),
            ),
          ],
        ),
      ),
    );
  }
}
