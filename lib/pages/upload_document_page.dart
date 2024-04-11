import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class UploadDocumentPage extends StatefulWidget {
  @override
  State<UploadDocumentPage> createState() => _UploadDocumentPageState();
}


class _UploadDocumentPageState extends State<UploadDocumentPage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Document Page'),
      ),
      body: Stack(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/shopSelection');
            },
            child: Text('Go Back to Shop Selection Page'),
          ),
        ],
      ),
    );
  }

}