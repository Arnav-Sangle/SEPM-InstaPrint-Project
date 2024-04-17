import 'package:flutter/material.dart';
import 'package:insta_print_app/pages/request_details_page.dart';
import 'package:insta_print_app/pages/shop_selection_page.dart';

class RequestHistoryDetailsPage extends StatefulWidget {
  @override
  _RequestHistoryDetailsPageState createState() =>
      _RequestHistoryDetailsPageState();
}

class _RequestHistoryDetailsPageState extends State<RequestHistoryDetailsPage> {

  String color = isBlackAndWhite ? 'Black & White' : 'Colored' ;
  String sided = isSingleSided ? 'Single' : 'Double' ;
  String orientation = isPortrait ? 'Portrait' : 'Landscape' ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Request History Details'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: DataTable(
          columns: [
            DataColumn(label: Text('File Name', style: TextStyle(fontWeight: FontWeight.normal))),
            DataColumn(label: Text('Document.pdf', style: TextStyle(fontWeight: FontWeight.normal))),
          ],
          rows: [
            DataRow(cells: [
              DataCell(Text('Copies')),
              DataCell(Text('${copies}', style: TextStyle(fontWeight: FontWeight.normal))),
            ]),
            DataRow(cells: [
              DataCell(Text('Pages')),
              DataCell(Text('${pages}', style: TextStyle(fontWeight: FontWeight.normal))),
            ]),
            DataRow(cells: [
              DataCell(Text('Color')),
              DataCell(Text('${color}', style: TextStyle(fontWeight: FontWeight.normal))),
            ]),
            DataRow(cells: [
              DataCell(Text('Sided')),
              DataCell(Text('Double', style: TextStyle(fontWeight: FontWeight.normal))),
            ]),
            DataRow(cells: [
              DataCell(Text('Orientation')),
              DataCell(Text('Portrait', style: TextStyle(fontWeight: FontWeight.normal))),
            ]),
            DataRow(cells: [
              DataCell(Text('Total Cost')),
              DataCell(Text('${cost}', style: TextStyle(fontWeight: FontWeight.normal))),
            ]),
            DataRow(cells: [
              DataCell(Text('Shop')),
              DataCell(Text('${selectedShop}', style: TextStyle(fontWeight: FontWeight.normal))),
            ]),
            DataRow(cells: [
              DataCell(Text('Status')),
              DataCell(Text('Ongoing', style: TextStyle(fontWeight: FontWeight.normal))),
            ]),
          ],
        ),
      ),
    );
  }
}
