//LOC = 272

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'upload_document_page.dart';

String selectedShop = 'SK Print, PCCOE';

class Shop {
  final String name;
  final double lat;
  final double lng;

  Shop({required this.name, required this.lat, required this.lng});
  
}

class ShopSelectionPage extends StatefulWidget {
  @override
  State<ShopSelectionPage> createState() => _ShopSelectionPageState();
}

class _ShopSelectionPageState extends State<ShopSelectionPage> {

  final List<Shop> shops = [
    Shop(name: 'SK Print, PCCOE', lat: 18.65264588852068, lng: 73.76216583253517),
    Shop(name: 'Jinal Xerox', lat: 18.652713400452676, lng: 73.76103467753373),
    Shop(name: 'Bhakti Copiers', lat: 18.652485760422092, lng: 73.76084683335446),
    Shop(name: 'Samarpanam Stationary & Xerox', lat: 18.652713588458735, lng: 73.76119152399207),
    Shop(name: 'Copy line', lat: 18.650838682474358, lng: 73.76269388289178),
  ];

  // final Map<String, String> shopInfo = {
  //   'SK Print, PCCOE': 'Address 1, Price Rates: $5 (B&W), $10 (Color), Quality: Good',
  //   'Jinal Xerox': 'Address 2, Price Rates: $4 (B&W), $8 (Color), Quality: Medium',
  //   'Bhakti Copiers': 'Address 3, Price Rates: $6 (B&W), $12 (Color), Quality: Excellent',
  //   'Samarpanam Stationary & Xerox': 'Address 4, Price Rates: $4 (B&W), $8 (Color), Quality: Medium',
  //   'Copy line': 'Address 5, Price Rates: $3 (B&W), $6 (Color), Quality: Good',
  // };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop Selection Page',
          style: TextStyle(
            color: Colors.white, // Set text color to white
            fontWeight: FontWeight.bold, // Set text font weight to bold
          ),
        ),
        // backgroundColor: Color.fromRGBO(113, 208, 255, 1.0),
        backgroundColor: Color.fromRGBO(72, 191, 250, 1.0),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          content(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () => showShopList(),
                child: const Text('Show List of Shops'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //

  final MapController mapController = MapController();

  Widget content() {
    return FlutterMap(
      mapController: mapController,
      options: const MapOptions(
        initialCenter: LatLng(18.65178677875539, 73.76165144957872), // PCCOE - Pimpri Chinchwad College Of Engineering
        initialZoom: 18,
        interactionOptions: InteractionOptions(flags: ~InteractiveFlag.doubleTapDragZoom),
      ),
      children: [
        openStreetMapTileLayer,
        MarkerLayer(markers: createMarkers(shops, context)),
      ],
    );
  }

  //



  List<Marker> createMarkers(List<Shop> shops, BuildContext context) {
    return shops.map((shop) {
      return Marker(
        point: LatLng(shop.lat, shop.lng),
        width: 60,
        height: 60,
        alignment: Alignment.centerLeft,
        child: GestureDetector(
          onTap: () {
            showShopDetails(context, shop.name);
            selectShop(shop.name); // Call selectShop when a marker is tapped
          },
          child: Icon(
            Icons.location_pin,
            size: 60,
            color: shop.name == selectedShop ? Colors.red : Colors.blueGrey, // Change color if selected
          ),
        ),
      );
    }).toList();
  }

  //

  void showShopList() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ListView(
          children: [
            shopListTile('SK Print, PCCOE'),
            shopListTile('Jinal Xerox'),
            shopListTile('Bhakti Copiers'),
            shopListTile('Samarpanam Stationary & Xerox'),
            shopListTile('Copy line'),
            
            // ListTile(
            //   title: const Text('SK Print, PCCOE'),
            //   onTap: () => selectShop('SK Print, PCCOE'),
            // ),
            // ... Add more ListTile widgets for other shops
          ],
        );
      },
    );
  }

  ListTile shopListTile(String shopName) {
    return ListTile(
      title: Text(shopName),
      selected: selectedShop == shopName,
      onTap: () => selectShop(shopName),
    );
  }






  void selectShop(String shopName) {

    setState(() {
      selectedShop = shopName;
      // No need to loop through shops here, the createMarkers method will handle marker updates

      for (var shop in shops) {
        if (shop.name == shopName) {
          mapController.move(LatLng(shop.lat, shop.lng), mapController.camera.zoom);
          break;
        }
      }

    });

    Navigator.pop(context); // Close the bottom sheet

    showShopDetails(context, shopName);

  }






  void showShopDetails(BuildContext context, String shopName) {
    // Sample data for the shop details
    final shopDetails = {
      'SK Print, PCCOE': {
        'image': 'assets/images/SK Print, PCCOE.png',
        'address': 'Pimpri Chinchwad College of Engineering, Sector No. 26, Pradhikaran, Nigdi, Pimpri-Chinchwad, Maharashtra 411044',
        // 'mapLink': 'https://www.google.com/maps',
        'timing': 'Closes 7pm',
        'bwRate': '2',
        'colorRate': '10',
        'quality': 'High',
      },
      'Jinal Xerox': {
        'image': 'assets/images/Jinal Xerox.png',
        'address': 'Akurdi Railway Station Rd, Sector No. 26, Pradhikaran, Nigdi, Pimpri-Chinchwad, Maharashtra 411044',
        // 'mapLink': 'https://www.google.com/maps',
        'timing': 'Closes 10pm',
        'bwRate': '2',
        'colorRate': '10',
        'quality': 'High',
      },
      'Bhakti Copiers': {
        'image': 'assets/images/Bhakti Copiers.png',
        'address': 'Shop No R4, Dhruv darshan Society PCP College, Pimpri-Chinchwad, Maharashtra 411044',
        // 'mapLink': 'https://www.google.com/maps',
        'timing': 'Closes 10pm',
        'bwRate': '2',
        'colorRate': '10',
        'quality': 'High',
      },
      'Samarpanam Stationary & Xerox': {
        'image': 'assets/images/Samarpanam Stationary & Xerox.png',
        'address': 'Shop No-12, A Wing, Sector No. 26, Pradhikaran, Nigdi, Pune, Pimpri-Chinchwad, Maharashtra 411044',
        // 'mapLink': 'https://www.google.com/maps',
        'timing': 'Closes 9pm',
        'bwRate': '2',
        'colorRate': '10',
        'quality': 'High',
      },
      'Copy line': {
        'image': 'assets/images/Copy line.png',
        'address': 'Prakash Gad Society, near Pccoe College, GPRA Quarters, Sector No. 26, Pradhikaran, Akurdi, Pimpri-Chinchwad, Maharashtra 411044',
        // 'mapLink': 'https://www.google.com/maps',
        'timing': 'Closes 9pm',
        'bwRate': '2',
        'colorRate': '10',
        'quality': 'High',
      },
      // ... Add details for other shops
    };

    final details = shopDetails[shopName];

    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Image.asset(
                    details!['image']??"",          // https://stackoverflow.com/questions/67967453/string-can-not-convert-to-string-in-dart
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          shopName,
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5),
                        Text('Address: ${details['address']}'),
                        SizedBox(height: 5),
                        Text('Timing: ${details['timing']}'),
                        // InkWell(
                        //   onTap: () {
                        //     // Open the map link
                        //     launchUrlString(details['timing']??"");
                        //   },
                        //   child: Text(
                        //     'View on Map',
                        //     style: TextStyle(color: Colors.blue),
                        //   ),
                        // ),
                        Text('B&W Rate: Rs. ${details['bwRate']}'),
                        Text('Color Rate: Rs. ${details['colorRate']}'),
                        Text('Quality: ${details['quality']}'),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Close the bottom sheet
                    },
                    child: Text('Back'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to the Upload Document page
                      Navigator.pushNamed(context, '/requestDetails');
                    },
                    child: Text('Proceed'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }



}






TileLayer get openStreetMapTileLayer => TileLayer(
  urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
  // userAgentPackageName: "dev.fleaflet.flutter_map.example",
  userAgentPackageName: "com.example.app",
);







// Inside the showSheet() function, a list of shops with their names ('SK Print, PCCOE', 'Jinal Xerox', 'Bhakti Copiers', 'Samarpanam Stationary & Xerox', 'Copy line') should be shown,
// when a shop is selected from the list its information (name, address, price) should be shown below and the location_pin of that shop on the map turns red

