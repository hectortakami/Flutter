import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:qr_scanner/models/scan.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLManager {
  static Database? _database;
  static final SQLManager db = SQLManager._();
  static const databaseName = 'SQLiteDB.db';

  SQLManager._();

  // Validates if SQLite Database exists or creates one
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await initDB();
      return _database!;
    }
  }

  // Creates the database
  Future<Database?> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, databaseName);
    //print(path);
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
            CREATE TABLE SCANS(
              id INTEGER PRIMARY KEY,
              type TEXT,
              value TEXT
            );
          ''');
      },
    );
  }

  // Inserts new register to database
  Future<int?> insert2DB(ScanModel registry) async {
    const tableName = 'SCANS';
    final db = await database;
    final uniqueID = await db.insert(tableName, registry.toJson());
    return uniqueID;
  }

  // Get register by unique identifier
  Future<ScanModel?> getByID(int uniqueID) async {
    const tableName = 'SCANS';
    final db = await database;
    final register = await db.query(
      tableName,
      where: 'id=?',
      whereArgs: [uniqueID],
    );
    return register.isNotEmpty ? ScanModel.fromJson(register.first) : null;
  }

  // Update register by unique identifier
  Future<int?> updateByID(ScanModel updatedRegister) async {
    const tableName = 'SCANS';
    final db = await database;
    final registerID = await db.update(
      tableName,
      updatedRegister.toJson(),
      where: 'id=?',
      whereArgs: [updatedRegister.id],
    );
    return registerID;
  }

  // Get all registers from table
  Future<List<ScanModel>> getTable(int uniqueID) async {
    const tableName = 'SCANS';
    final db = await database;
    final tableRegisters = await db.query(tableName);
    return tableRegisters.isNotEmpty
        ? tableRegisters
            .map((register) => ScanModel.fromJson(register))
            .toList()
        : [];
  }

  // Get registers filtered by property
  Future<List<ScanModel>> getFiltered(String property, String value) async {
    const tableName = 'SCANS';
    final db = await database;
    final filteredRegisters = await db.query(
      tableName,
      where: '$property=?',
      whereArgs: [value],
    );
    return filteredRegisters.isNotEmpty
        ? filteredRegisters
            .map((register) => ScanModel.fromJson(register))
            .toList()
        : [];
  }

  // Delete register by unique identifier
  Future<int?> deleteByID(int uniqueID) async {
    const tableName = 'SCANS';
    final db = await database;
    final registerID = await db.delete(
      tableName,
      where: 'id=?',
      whereArgs: [uniqueID],
    );
    return registerID;
  }

  // Delete all registers from table
  Future<int?> deleteTable() async {
    const tableName = 'SCANS';
    final db = await database;
    final deletedCount = await db.delete(tableName);
    return deletedCount;
  }
}
