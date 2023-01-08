import 'package:equitysoft_practical/database/db_helper.dart';
import 'package:equitysoft_practical/modules/category/models/category_model.dart';
import 'package:sqflite/sqlite_api.dart';

class CategoryTable {
  static const String TABLE_NAME_CATEGORY_TABLE = "categoryList";
  static const String clm_cat_id = "id";
  static const String clm_cat_name = "cate_name";

  static const CREATE_TABLE_CATEGORY_LIST =
      """CREATE TABLE $TABLE_NAME_CATEGORY_TABLE(
      $clm_cat_id integer primary key autoincrement,
      $clm_cat_name text
      )""";


  CategoryModel categoryModel = CategoryModel(categoryName: 'test');


  static Future<int> addNewCategory({
    required CategoryModel categoryModel,
  }) async {
    Database? db = await DbHelper.getDataBaseInstance();
    return db!.insert(
      TABLE_NAME_CATEGORY_TABLE,
      categoryModel.toMapForCategoryDb(),
    );
  }

  static Future<CategoryModel?> getCategoryById({
    required int categoryId,
  }) async {
    Database? db = await DbHelper.getDataBaseInstance();

    final List<Map<String, dynamic>> listOfMaps = await db!.rawQuery(
        'SELECT * FROM $TABLE_NAME_CATEGORY_TABLE WHERE $clm_cat_id = ?',
        [categoryId]);

    if (listOfMaps.isNotEmpty) {
      return listOfMaps.map((e) => CategoryModel.fromDb(e)).toList().first;
    }
    return null;
  }

  static Future<int> deleteCategoryByCategoryId({
    required int categoryId,
  }) async {
    Database? db = await DbHelper.getDataBaseInstance();
    return db!.delete(TABLE_NAME_CATEGORY_TABLE,
        where: "$clm_cat_id = ?", whereArgs: [categoryId]);
  }

  static Future<List<CategoryModel>> getAllCategoryFromDb() async {
    Database? db = await DbHelper.getDataBaseInstance();
    final List<Map<String, dynamic>> listOfMaps =
        await db!.rawQuery('SELECT * FROM $TABLE_NAME_CATEGORY_TABLE');
    if (listOfMaps.isNotEmpty) {
      return listOfMaps.map((e) => CategoryModel.fromDb(e)).toList();
    }
    return [];
  }
}
