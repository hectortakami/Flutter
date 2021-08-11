import 'package:flutter/material.dart';
import 'package:flutter_qrscanner_sqlite/models/scan_model.dart';
import 'package:flutter_qrscanner_sqlite/pages/maps_page.dart';
import 'package:flutter_qrscanner_sqlite/pages/urls_page.dart';
import 'package:flutter_qrscanner_sqlite/providers/db_provider.dart';
import 'package:flutter_qrscanner_sqlite/providers/ui_provider.dart';
import 'package:flutter_qrscanner_sqlite/widgets/bottom_navbar.dart';
import 'package:flutter_qrscanner_sqlite/widgets/scan_fab.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('QRScanner SQLite'),
        actions: [
          IconButton(
              onPressed: () {
                final dbProvider =
                    Provider.of<DBProvider>(context, listen: false);
                dbProvider.clearAll();
              },
              icon: Icon(Icons.delete_forever))
        ],
      ),
      body: _handleHomePage(context, uiProvider.menuOpt),
      floatingActionButton: ScanFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavBar(),
    );
  }

  Widget _handleHomePage(BuildContext context, int tabIndex) {
    final dbProvider = Provider.of<DBProvider>(context, listen: false);

    if (tabIndex == 1) {
      dbProvider.loadByFilter('qr_type', 'http');
      return URLsPage();
    } else {
      dbProvider.loadByFilter('qr_type', 'geo');
      return MapsPage();
    }
  }
}
