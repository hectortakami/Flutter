import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_qrscanner_sqlite/models/scan_model.dart';
import 'package:flutter_qrscanner_sqlite/providers/db_provider.dart';
import 'package:provider/provider.dart';

class ScanFAB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.qr_code_scanner),
      onPressed: () async {
        //String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        //    '#3D8BEF', 'Cancel', false, ScanMode.QR);
        //print(barcodeScanRes);
String barcodeScanRes = 'geo:99.99,-19.95';
        // String barcodeScanRes = 'http://google.com';
        final dbProvider = Provider.of<DBProvider>(context, listen: false);
        dbProvider.create(new ScanModel(value: barcodeScanRes));
      },
    );
  }
}
