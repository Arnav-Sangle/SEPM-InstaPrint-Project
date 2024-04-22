//LOC = 55

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
        title: Text('Welcome to InstaPrint!',
          style: TextStyle(
            color: Colors.white, // Set text color to white
            fontWeight: FontWeight.bold, // Set text font weight to bold
          ),
        ),
        // backgroundColor: Color.fromRGBO(113, 208, 255, 1.0),
        backgroundColor: Color.fromRGBO(72, 191, 250, 1.0),
        centerTitle: true,
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
                Navigator.pushNamed(context, '/requestHistory');
              },
              text: "Review Previous Request",
            ),
          ],
        ),
      ),
    );
  }
}
