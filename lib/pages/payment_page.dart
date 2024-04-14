
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:upi_payment_qrcode_generator/upi_payment_qrcode_generator.dart';
import 'package:upi_india/upi_india.dart';


class PaymentPage extends StatefulWidget{
  PaymentPage({Key?key}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  int pages=23;

  double rate=2;

  bool bW =true;

  double pay=0;

  UpiIndia _upiIndia = UpiIndia();

  UpiApp app = UpiApp.googlePay;

  @override
  Widget build(BuildContext context){
    if (pages % 2 == 0){
      pay = (pages / 2) * rate;} // Calculate pay here
    else {
      pay = (pages / 2) * rate + 1;
    }
    final upiDetails = UPIDetails(
      upiID: "vedantsonawanescitech@okhdfcbank",
      payeeName: "Vedant",
      amount: pay,
    );
    Future<UpiResponse> initiateTransaction(UpiApp app) async {
      return _upiIndia.startTransaction(
        app: app,
        receiverUpiId: "vedantsonawanescitech@okhdfcbank",
        receiverName: 'Vedant',
        amount: pay, transactionRefId: 'Test',
      );
    }
    return  MaterialApp(
      home:Scaffold(
        appBar: AppBar(
          toolbarTextStyle: const TextStyle(color: Colors.white),
          title:const Text('Payment Module'),
          backgroundColor: Colors.blue,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${pages / 2 * rate} INR', // Display the result here
                style: const TextStyle(fontSize: 24),
              ),
              SizedBox(height: 10),
              UPIPaymentQRCode(upiDetails: upiDetails, size: 200,),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(height: 20), // Add a new line with Container
                    const Text(
                      'QR code for IOS devices',
                      style: TextStyle(fontSize: 24),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  initiateTransaction(app);
                },
                child: const Text('Pay via UPI'),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items:const [
            BottomNavigationBarItem(
                label: 'Home',
                icon: Icon(
                  Icons.home,
                  color: Colors.blue,
                  size: 24.0,
                  semanticLabel: 'Text to announce in accessibility modes',)
            ),
            BottomNavigationBarItem(
                label: 'Settings',
                icon: Icon(Icons.settings,
                  color: Colors.black,
                  size: 24.0,
                  semanticLabel: 'Text to announce in accessibility modes',)
            ),
          ],

        ),
      ),
      debugShowCheckedModeBanner: false,

    );
  }
}
