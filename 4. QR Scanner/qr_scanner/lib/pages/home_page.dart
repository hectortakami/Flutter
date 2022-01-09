// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/models/scan.dart';
import 'package:qr_scanner/pages/list_page.dart';
import 'package:qr_scanner/providers/sql_provider.dart';
import 'package:qr_scanner/providers/ui_provider.dart';
import 'package:qr_scanner/shared/bottom_navbar.dart';
import 'package:qr_scanner/shared/url_launcher.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('History'),
        actions: [
          IconButton(
              onPressed: () {
                final sqlProvider =
                    Provider.of<SQLProvider>(context, listen: false);
                sqlProvider.removeAll();
              },
              icon: Icon(Icons.delete_forever))
        ],
      ),
      body: handlePageByTab(context),
      bottomNavigationBar: CustomNavigationBar(),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        child: Icon(Icons.qr_code_scanner),
        onPressed: () async {
          final sqlProvider = Provider.of<SQLProvider>(context, listen: false);
          String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
            '#ff6666',
            'Cancel',
            true,
            ScanMode.BARCODE,
          );
          // String barcodeScanRes = 'https://google.com';
          // String barcodeScanRes = 'geo:19.4759619,-99.2725357';
          sqlProvider.addScan(ScanModel(value: barcodeScanRes));
          if (barcodeScanRes == '-1') return;
          if (barcodeScanRes.contains('http')) {
            final uiProvider = Provider.of<UIProvider>(context, listen: false);
            uiProvider.navTabIndex = 1;
            URLLauncher().launchURL(barcodeScanRes);
          }
          if (barcodeScanRes.contains('geo')) {
            final uiProvider = Provider.of<UIProvider>(context, listen: false);
            uiProvider.navTabIndex = 0;
            Navigator.pushNamed(context, 'map', arguments: barcodeScanRes);
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  handlePageByTab(BuildContext context) {
    final uiProvider = Provider.of<UIProvider>(context);
    final sqlProvider = Provider.of<SQLProvider>(context, listen: false);

    int tabIndex = uiProvider.navTabIndex;
    switch (tabIndex) {
      case 0:
        sqlProvider.getScansByType('geo');
        return ListPage(type: 'geo');
      case 1:
        sqlProvider.getScansByType('http');
        return ListPage(type: 'http');
      default:
        sqlProvider.getScansByType('geo');
        return ListPage(type: 'geo');
    }
  }
}
