//LOC = 196

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../components/my_button.dart';
import '../components/my_textfield.dart';
import '../components/square_tile.dart';
import 'login_page.dart';

import 'package:insta_print_app/api/firestore.dart';


String selectedRegister = 'blank';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Text editing controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final FirestoreServices firestoreServices = FirestoreServices();

  // bool isStudent = true;

  Future<void> register(BuildContext context) async {
    try {
      if (passwordController.text != confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Passwords do not match'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // selectedRegister = isStudent ? 'Login Student' : 'Login Shop';



      // Navigate to the login page after successful registration
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (context) => LoginPage()),
      // );
    } catch (e) {
      // Handle registration errors
      print('Error registering user: $e');
      // You can display an error message here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                // Welcome text
                Image.asset(
                  'assets/images/instaPrintLogo.png',
                  width: 100,
                  height: 100,
                ),
                const SizedBox(height: 50),
                // Welcome text
                Text(
                  "Welcome New User!",
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),

                // Register as a Shop or User
                // SizedBox(height: 25),
                // Text("selectedRegister = $selectedRegister"),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [

                          Radio(
                            value: 'Login Student',
                            groupValue: selectedRegister,
                            onChanged: (value) {
                              setState(() {
                                selectedRegister = value??"";
                              });
                            },
                          ),
                          Text('Student'),

                          SizedBox(width: 20),

                          Radio(
                            value: 'Login Shop',
                            groupValue: selectedRegister,
                            onChanged: (value) {
                              setState(() {
                                selectedRegister = value??"";
                              });
                            },
                          ),
                          Text('Shop'),
                        ],
                      ),
                      SizedBox(width: 20),
                    ],
                  ),
                ),

                // Email
                SizedBox(height: 25),
                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),

                // Password
                SizedBox(height: 10),
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),

                // Confirm Password
                SizedBox(height: 10),
                MyTextField(
                  controller: confirmPasswordController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                ),

                // Forgot password
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot password?',
                        style: TextStyle(
                          color: Colors.blue[600],
                        ),
                      ),
                    ],
                  ),
                ),

                // Register button
                SizedBox(height: 25),
                MyButton(
                  text: 'Register Now',
                  onTap: () {
                    register(context);
                    // Add the registration data to Firestore
                    firestoreServices.addRegister(emailController.text);
                    Navigator.pushNamed(context, '/login');
                  }
                ),

                // Already a member, login now
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already a member?',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/login');
                            // Navigator.pushReplacement(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => LoginPage()),
                            // );
                          },
                          child: Text(
                            'Login now',
                            style: TextStyle(
                              color: Colors.blue[500],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
