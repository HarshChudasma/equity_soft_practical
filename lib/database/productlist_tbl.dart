import 'package:equitysoft_practical/database/db_helper.dart';
import 'package:equitysoft_practical/modules/product/models/product_model.dart';
import 'package:sqflite/sqflite.dart';

class ProductListTable{
  static const String TABLE_NAME_PRODUCT_TABLE = "productList";
  static const String clm_product_id = "id";
  static const String clm_product_name = "product_name";
  static const String clm_category_id = "category_id";
  static const String clm_category_name = "category_name";
  static const String clm_company_id = "company_id";
  static const String clm_company_name = "company_name";
  static const String clm_description = "description";
  static const String clm_price = "price";
  static const String clm_qty = "qty";
  static const String clm_product_img = "product_img";

  static const CREATE_TABLE_COMPANY_LIST =
  """CREATE TABLE $TABLE_NAME_PRODUCT_TABLE(
      $clm_product_id integer primary key autoincrement,
      $clm_product_name text,
      $clm_category_id integer,
      $clm_category_name text,
      $clm_company_id integer,
      $clm_company_name text,
      $clm_description text,
      $clm_price text,
      $clm_qty text,
      $clm_product_img BLOB
      )""";

  static Future<int> addNewProduct({
    required ProductModel productModel,
  }) async {
    Database? db = await DbHelper.getDataBaseInstance();
    return db!.insert(
      TABLE_NAME_PRODUCT_TABLE,
      productModel.toMapForCategoryDb(),
    );
  }

  static Future<ProductModel?> getProductById({
    required int productId,
  }) async {
    Database? db = await DbHelper.getDataBaseInstance();

    final List<Map<String, dynamic>> listOfMaps = await db!.rawQuery(
        'SELECT * FROM $TABLE_NAME_PRODUCT_TABLE WHERE $clm_product_id = ?',
        [productId]);

    if (listOfMaps.isNotEmpty) {
      return listOfMaps
          .map((e) => ProductModel.fromDb(e))
          .toList()
          .first;
    }
    return null;
  }

  static Future<List<ProductModel>> getAllProductFromDb() async {
    Database? db = await DbHelper.getDataBaseInstance();
    final List<Map<String, dynamic>> listOfMaps =
    await db!.rawQuery('SELECT * FROM $TABLE_NAME_PRODUCT_TABLE');
    if (listOfMaps.isNotEmpty) {
      return listOfMaps.map((e) => ProductModel.fromDb(e)).toList();
    }
    return [];
  }

  static Future<int> deleteProductByProductId({
    required int productId,
  }) async {
    Database? db = await DbHelper.getDataBaseInstance();
    return db!.delete(TABLE_NAME_PRODUCT_TABLE,
        where: "$clm_product_id = ?", whereArgs: [productId]);
  }


}