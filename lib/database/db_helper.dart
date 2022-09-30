import 'package:lsp_jti/model/cash_flow.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class DbHelper {
  static final DbHelper _instance = DbHelper._internal();
  static Database? _database;

  //inisialisasi beberapa variabel yang dibutuhkan
  final String tableName = 'cashflow';
  final String columnId = 'id';
  final String columnTgl = 'tgl';
  final String columnCash = 'cash';
  final String columnJenis = 'jenis';
  final String columnKeterangan = 'keterangan';

  DbHelper._internal();
  factory DbHelper() => _instance;

  //cek apakah database ada
  Future<Database?> get _db async {
    if (_database != null) {
      return _database;
    }
    _database = await _initDb();
    return _database;
  }

  Future<Database?> _initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'cashflow.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  //membuat tabel dan field-fieldnya
  Future<void> _onCreate(Database db, int version) async {
    var sql = "CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY, "
        "$columnTgl DATE,"
        "$columnCash INT,"
        "$columnJenis INT,"
        "$columnKeterangan TEXT)";
    await db.execute(sql);
  }

  //insert ke database
  Future<int?> saveCashFlow(CashFlow cashFlow) async {
    var dbClient = await _db;
    print("cashFlow : $cashFlow");
    return await dbClient!.insert(tableName, cashFlow.toMap());
  }

  //read database
  Future<List?> getAllCashFlow() async {
    var dbClient = await _db;
    var result = await dbClient!.query(tableName, columns: [
      columnId,
      columnTgl,
      columnCash,
      columnJenis,
      columnKeterangan
    ]);

    return result.toList();
  }

  Future<List?> getTotalPemasukan() async {
    var dbClient = await _db;
    var result = await dbClient!.rawQuery(
        'SELECT SUM(cash) as total_pemasukan FROM $tableName WHERE jenis=?',
        ['pemasukan']);
    return result.toList();
  }

  Future<List?> getTotalPengeluaran() async {
    var dbClient = await _db;
    var result = await dbClient!.rawQuery(
        'SELECT SUM(cash) as total_pengeluaran FROM $tableName WHERE jenis=?',
        ['pengeluaran']);
    return result.toList();
  }

  //update database
  Future<int?> updateCashFlow(CashFlow cashFlow) async {
    var dbClient = await _db;
    return await dbClient!.update(tableName, cashFlow.toMap(),
        where: '$columnId = ?', whereArgs: [cashFlow.id]);
  }

  //hapus database
  Future<int?> deleteCashFlow(int id) async {
    var dbClient = await _db;
    return await dbClient!
        .delete(tableName, where: '$columnId = ?', whereArgs: [id]);
  }
}
