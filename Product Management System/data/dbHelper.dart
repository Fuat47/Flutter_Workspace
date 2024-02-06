import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/product.dart';

class DbHelper {
  late Database _db;

  Future<Database> get db async {
    _db = await initializeDb();

    return _db;
  }

  Future<Database> initializeDb() async {
    String dbPath = join(await getDatabasesPath(), "etrade.db");
    _db = await openDatabase(dbPath, version: 1, onCreate: createDb);
    return _db;
  }

  Future<void> createDb(Database db, int version) async {
    await db.execute(
        "CREATE TABLE products(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, description TEXT, unitPrice INTEGER)");
  }

  Future<List<Product>> getProducts() async {
    Database db = await this.db;
    var result = await db.query("products");
    return List.generate(result.length, (i) {
      return Product.fromObject(result[i]);
    });
  }

  Future<int> insert(Product product) async {
    Database db = await this.db;
    var result = await db.insert("products", product.toMap());
    return result;
  }

  Future<int> delete(int id) async {
    Database db = await this.db;
    var result = await db.rawDelete("DELETE FROM products WHERE id = $id");
    return result;
  }

  Future<int> update(Product product) async {
    Database db = await this.db;
    var result = await db.update("products", product.toMap(),
        where: "id=?", whereArgs: [product.id]);
    return result;
  }
}
