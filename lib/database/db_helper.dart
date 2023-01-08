import 'dart:io';
import 'package:equitysoft_practical/database/category_tbl.dart';
import 'package:equitysoft_practical/database/company_tbl.dart';
import 'package:equitysoft_practical/database/productlist_tbl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class DbHelper{
  static Database? db = null;
  static const String DB_NAME = "equotySoft.db";
  static const int DB_VERSION = 1;

  static Future<Database?> getDataBaseInstance() async{
    if(db == null){
      db = await init();
    }
    return db;
  }

  static Future<Database?> init() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final String dbPath = path.join(documentDirectory.path, DB_NAME);
    db = await openDatabase(
      dbPath,
      version: DB_VERSION,
      onCreate: (Database newDb, int version) {
        newDb.execute(CategoryTable.CREATE_TABLE_CATEGORY_LIST);
        newDb.execute(CompanyTable.CREATE_TABLE_COMPANY_LIST);
        newDb.execute(ProductListTable.CREATE_TABLE_COMPANY_LIST);
      },
    );
    return db;
  }

}