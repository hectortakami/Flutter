import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_qrscanner_sqlite/models/scan_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

// SQLite DATABASE MANAGER
class DBManager {
  static Database? _database;
  static final DBManager db = DBManager._();
  DBManager._();

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await initDB();
      return _database;
    }
  }

  // Initializes SQLite Database
  Future<Database> initDB() async {
    final databaseName = 'ScansDB';
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, '$databaseName.db');
    print(path);

    return openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('''
      CREATE TABLE Scans (
        id INTEGER PRIMARY KEY,
        qr_type TEXT,
        value TEXT
      );
        ''');
    });
  }

  // Insert a new register into the database
  Future<int> createRegister(ScanModel scan) async {
    final db = await database;
    final response = await db!.insert('Scans', scan.toJson());
    return response;
  }

  // Read all registers from the database
  Future<List<ScanModel>?> getAllRegisters() async {
    final db = await database;
    final response = await db!.query('Scans');
    return response.isNotEmpty
        ? response.map((e) => ScanModel.fromJson(e)).toList()
        : [];
  }

  // Read by ID registers from the database
  Future<ScanModel?> getRegisterByID(int id) async {
    final db = await database;
    final response =
        await db!.query('Scans', where: 'id = $id', whereArgs: [id]);
    return response.isNotEmpty ? ScanModel.fromJson(response.first) : null;
  }

  // Get only the registers that match the filterValue in certain attribute
  Future<List<ScanModel>?> filterByAttribute(
      String attribute, String filterValue) async {
    final db = await database;
    final response = await db!.rawQuery('''
    SELECT * FROM Scans
    WHERE $attribute == '$filterValue'
    ''');
    return response.isNotEmpty
        ? response.map((e) => ScanModel.fromJson(e)).toList()
        : [];
  }

  // Updates an existing register from the database
  Future<int> updateRegister(ScanModel scan) async {
    final db = await database;
    final response = await db!
        .update('Scans', scan.toJson(), where: 'id = ?', whereArgs: [scan.id]);
    return response;
  }

  // Deletes an individual register from the database
  Future<int> deleteRegisterByID(int id) async {
    final db = await database;
    final response =
        await db!.delete('Scans', where: 'id = ?', whereArgs: [id]);
    return response;
  }

  // Deletes all the registers from the database
  Future<int> deleteAllRegisters() async {
    final db = await database;
    final response = await db!.delete('Scans');
    return response;
  }
}

// CENTRALIZED DATA & OPERATIONS FROM DATABASE
class DBProvider extends ChangeNotifier {
  List<ScanModel> registers = [];

  create(ScanModel scan) async {
    final index = await DBManager.db.createRegister(scan);
    scan.id = index;
    registers.add(scan);
    notifyListeners();
  }

  readAll() async {
    final allRegisters = await DBManager.db.getAllRegisters();
    this.registers = [...allRegisters!];
    notifyListeners();
  }

  loadByFilter(String attribute, String filterValue) async {
    final filteredRegisters =
        await DBManager.db.filterByAttribute(attribute, filterValue);
    this.registers = [...filteredRegisters!];
    notifyListeners();
  }

  clearByID(int id) async {
    await DBManager.db.deleteRegisterByID(id);
    readAll();
  }

  clearAll() async {
    await DBManager.db.deleteAllRegisters();
    this.registers = [];
    notifyListeners();
  }
}
