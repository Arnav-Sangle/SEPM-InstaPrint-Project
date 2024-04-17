import 'package:flutter/material.dart';
import 'package:insta_print_app/pages/request_history_details_page.dart';

class RequestHistoryPage extends StatefulWidget {
  @override
  _RequestHistoryPageState createState() => _RequestHistoryPageState();
}

class _RequestHistoryPageState extends State<RequestHistoryPage> {
  List<RequestRecord> records = [
    RequestRecord("18/08/22", "8:00 pm", "Rs. 87", "SK Print", "Ongoing"),
    RequestRecord("18/08/22", "8:00 pm", "Rs. 87", "SK Print", "Ongoing"),
    // RequestRecord("Record 2", "Details 2", "Date 2", "Status 2"),
    // Add more records here as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Request History'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: List.generate(records.length, (index) {
            return buildRow(records[index]);
          }),
        ),
      ),
    );
  }

  Widget buildRow(RequestRecord record) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              record.date,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12.0),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            child: Text(
              record.time,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12.0),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            child: Text(
              record.cost,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12.0),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            child: Text(
              record.shop,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12.0),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            child: Text(
              record.status,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12.0),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

}

class RequestRecord {
  final String date;
  final String time;
  final String cost;
  final String shop;
  final String status;


  RequestRecord(this.date, this.time, this.cost, this.shop, this.status);
}