// LOC = 49

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/material/colors.dart';

import 'package:insta_print_app/pages/home_page.dart';
import 'package:insta_print_app/pages/login_page.dart';
import 'package:insta_print_app/pages/payment_page.dart';
import 'package:insta_print_app/pages/register_page.dart';
import 'package:insta_print_app/pages/request_details_page.dart';
import 'package:insta_print_app/pages/request_history_page.dart';
import 'package:insta_print_app/pages/shop_selection_page.dart';
import 'package:insta_print_app/pages/upload_document_page.dart';
import 'package:insta_print_app/pages/request_history_details_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,

      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple),
      // ),

      // theme: ThemeData(
      //   colorScheme: ColorScheme.light().copyWith(primary: Colors.pink.shade800),
      // ),

      theme: ThemeData(
        // hintColor: Colors.pink.shade900,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(background: Color.fromRGBO(255, 255, 255, 1.0)),
      ),

      home: LoginPage(),
      initialRoute: '/',
      routes: {
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/home': (context) => HomePage(),
        '/shopSelection': (context) => ShopSelectionPage(),
        // '/uploadDocument': (context) => UploadPage(),
        '/requestDetails': (context) => RequestDetailsPage(),
        '/payment': (context) => PaymentPage(),

        '/requestHistory': (context) => RequestHistoryPage(),
        '/requestHistoryDetails': (context) => RequestHistoryDetailsPage(),

        // Add other routes here as needed
      },
    );
  }
}
