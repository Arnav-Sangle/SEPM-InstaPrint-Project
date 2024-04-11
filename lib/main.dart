import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:insta_print_app/pages/home_page.dart';
import 'package:insta_print_app/pages/login_page.dart';
import 'package:insta_print_app/pages/register_page.dart';
import 'package:insta_print_app/pages/request_history_page.dart';
import 'package:insta_print_app/pages/shop_selection_page.dart';
import 'package:insta_print_app/pages/upload_document_page.dart';

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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple),
        // useMaterial3: true, // Material 3 is not yet stable
      ),
      home: LoginPage(),
      initialRoute: '/',
      routes: {
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/home': (context) => HomePage(),
        '/shopSelection': (context) => ShopSelectionPage(),
        '/uploadDocument': (context) => UploadPage(),
        '/requestHistory': (context) => RequestHistoryPage(),
        // Add other routes here as needed
      },
    );
  }
}
