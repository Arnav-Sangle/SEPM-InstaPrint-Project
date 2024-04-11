import 'package:flutter/material.dart';

import '../components/default_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
            DefaultButton(
              text: "Create Print Request",
              onTap: () {
                Navigator.pushNamed(context, '/shopSelection');
              },
            ),
            SizedBox(height: 20),
            // Section 2: Review previous requests
            DefaultButton(
              onTap: () {
                // Navigate to review previous requests page
              },
              text: "Review Previous Request",
            ),
          ],
        ),
      ),
    );
  }
}
