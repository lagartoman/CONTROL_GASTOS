import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/gasto.dart';

class DBHelper {
  static Database? _db;

  // Singleton
  DBHelper._privateConstructor();
  static final DBHelper instance = DBHelper._privateConstructor();

  static Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'gastos.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE gastos(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            descripcion TEXT,
            categoria TEXT,
            monto REAL,
            fecha TEXT
          )
        ''');
      },
    );
  }

  static Future<Database> getDatabase() async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  static Future<int> insertarGasto(Gasto gasto) async {
    final db = await getDatabase();
    return await db.insert('gastos', gasto.toJson());
  }

  static Future<List<Gasto>> obtenerGastos() async {
    final db = await getDatabase();
    final result = await db.query('gastos', orderBy: 'fecha DESC');
    return result.map((json) => Gasto.fromJson(json)).toList();
  }

  static Future<int> eliminarGasto(int id) async {
    final db = await getDatabase();
    return await db.delete('gastos', where: 'id = ?', whereArgs: [id]);
  }

  static Future<int> actualizarGasto(Gasto gasto) async {
    final db = await getDatabase();
    return await db.update(
      'gastos',
      gasto.toJson(),
      where: 'id = ?',
      whereArgs: [gasto.id],
    );
  }
}
