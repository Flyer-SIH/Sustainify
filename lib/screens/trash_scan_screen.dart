import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class Product {
  final String barcode;
  final String type;

  Product(this.barcode, this.type);
}

List<Product> products = [
  Product('8902519001139', 'notebook'),
  Product('987654321', 'Electronic'),
  // Add more products and their types as needed
];

class ScanProductScreen extends StatefulWidget {
  const ScanProductScreen({super.key});

  @override
  _ScanProductScreenState createState() => _ScanProductScreenState();
}

class _ScanProductScreenState extends State<ScanProductScreen> {
  String barcodeScanResult = "Scan a product barcode";

  void scanProduct() async {
    String barcode = await FlutterBarcodeScanner.scanBarcode(
      "#ff6666", // Color of the scan button
      "Cancel", // Text for the cancel button
      true, // Flashlight mode
      ScanMode.BARCODE,
    );

    setState(() {
      barcodeScanResult = barcode;
    });

    Product product = products.firstWhere(
      (p) => p.barcode == barcodeScanResult,
      orElse: () => Product(barcodeScanResult, 'Unknown'),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Product Type'),
          content: Text('Type: ${product.type}'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Scanner'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              barcodeScanResult,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: scanProduct,
              child: Text("Scan Product"),
            ),
          ],
        ),
      ),
    );
  }
}
