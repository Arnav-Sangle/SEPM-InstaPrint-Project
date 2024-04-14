import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:insta_print_app/api/firestore.dart';

import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart';
//import 'package:insta_print_app/components/button_widget.dart';
import 'package:insta_print_app/api/firebase_api.dart';


class RequestDetailsPage extends StatefulWidget {
  @override
  _RequestDetailsPageState createState() => _RequestDetailsPageState();
}

class _RequestDetailsPageState extends State<RequestDetailsPage> {
  UploadTask? task;
  File? file;

  bool isBlackAndWhite = true;
  bool isSingleSided = true;
  bool isPortrait = true;
  int copies = 1;
  int pages = 1;
  String email = 'null';

  @override
  Widget build(BuildContext context) {
    final fileName = file != null ? basename(file!.path) : 'No File Selected';
    final FirestoreServices firestoreServices = FirestoreServices();

    return Scaffold(
      appBar: AppBar(
        title: Text('Request Details'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              'Pages:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            TextFormField(
              initialValue: '1',
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  pages = int.tryParse(value) ?? 1;
                });
              },
            ),
            SizedBox(height: 20),
            Text(
              'Color:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Checkbox(
                  value: isBlackAndWhite,
                  onChanged: (value) {
                    setState(() {
                      isBlackAndWhite = value ?? true;
                    });
                  },
                ),
                Text('B&W'),
                SizedBox(width: 20),
                Checkbox(
                  value: !isBlackAndWhite,
                  onChanged: (value) {
                    setState(() {
                      isBlackAndWhite = !(value ?? false);
                    });
                  },
                ),
                Text('Colored'),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Sided:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Checkbox(
                  value: isSingleSided,
                  onChanged: (value) {
                    setState(() {
                      isSingleSided = value ?? true;
                    });
                  },
                ),
                Text('Single'),
                SizedBox(width: 20),
                Checkbox(
                  value: !isSingleSided,
                  onChanged: (value) {
                    setState(() {
                      isSingleSided = !(value ?? false);
                    });
                  },
                ),
                Text('Double'),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Orientation:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Checkbox(
                  value: isPortrait,
                  onChanged: (value) {
                    setState(() {
                      isPortrait = value ?? true;
                    });
                  },
                ),
                Text('Portrait'),
                SizedBox(width: 20),
                Checkbox(
                  value: !isPortrait,
                  onChanged: (value) {
                    setState(() {
                      isPortrait = !(value ?? false);
                    });
                  },
                ),
                Text('Landscape'),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Copies:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            TextFormField(
              initialValue: '1',
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  copies = int.tryParse(value) ?? 1;
                });
              },
            ),
            SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  onPressed:
                    selectFile
                  ,
                  child: Text('Select File'),
                ),
                SizedBox(height: 8),
                Center (
                  child:Text(
                  fileName,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed:
                    uploadFile
                  ,
                  child: Text('Upload'),
                ),
                SizedBox(height: 20),
                task != null ? buildUploadStatus(task!) : Container(),
                const SizedBox(height: 50),
                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    firestoreServices.add(email, fileName, pages, isBlackAndWhite, isSingleSided, isPortrait, copies);
                    Navigator.pushNamed(context, '/payment');
                  },
                  child: Text('Pay up'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() => file = File(path));
  }

  Future uploadFile() async {
    if (file == null) return;

    final fileName = basename(file!.path);
    final destination = 'files/$fileName';

    task = FirebaseApi.uploadFile(destination, file!);
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    print('Download-Link: $urlDownload');
  }

  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
    stream: task.snapshotEvents,
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        final snap = snapshot.data!;
        final progress = snap.bytesTransferred / snap.totalBytes;
        final percentage = (progress * 100).toStringAsFixed(2);

        return Center (
          child: Text (
          '$percentage %',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        );
      } else {
        return Container();
      }
    },
  );

}




