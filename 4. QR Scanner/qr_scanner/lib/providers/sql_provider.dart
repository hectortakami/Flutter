import 'package:flutter/material.dart';
import 'package:qr_scanner/models/scan.dart';
import 'package:qr_scanner/providers/sql_manager.dart';

class SQLProvider extends ChangeNotifier {
  List<ScanModel> scans = [];

  getScansByType(String type) async {
    final response = await SQLManager.db.getFiltered('type', type);
    scans = [];
    scans.addAll(response);
    notifyListeners();
  }

  addScan(ScanModel registry) async {
    final id = await SQLManager.db.insert2DB(registry);
    registry.id = id;
    scans.add(registry);
    notifyListeners();
  }

  removeByID(ScanModel registry) async {
    await SQLManager.db.deleteByID(registry.id!);
    getScansByType(registry.type!);
  }

  removeAll() async {
    await SQLManager.db.deleteTable();
    scans = [];
    notifyListeners();
  }
}
