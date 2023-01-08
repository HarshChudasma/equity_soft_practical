import 'package:equitysoft_practical/database/db_helper.dart';
import 'package:equitysoft_practical/modules/company/models/company_model.dart';
import 'package:sqflite/sqlite_api.dart';

class CompanyTable{
  static const String TABLE_NAME_COMPANY_TABLE = "companyList";
  static const String clm_com_id = "id";
  static const String clm_com_name = "company_name";

  static const CREATE_TABLE_COMPANY_LIST =
  """CREATE TABLE $TABLE_NAME_COMPANY_TABLE(
      $clm_com_id integer primary key autoincrement,
      $clm_com_name text
      )""";

  static Future<int> addNewCompany({
    required CompanyModel companyModel,
  }) async {
    Database? db = await DbHelper.getDataBaseInstance();
    return db!.insert(
      TABLE_NAME_COMPANY_TABLE,
      companyModel.toMapForCategoryDb(),
    );
  }

  static Future<CompanyModel?> getCompanyById({
    required int companyId,
  }) async {
    Database? db = await DbHelper.getDataBaseInstance();

    final List<Map<String, dynamic>> listOfMaps = await db!.rawQuery(
        'SELECT * FROM $TABLE_NAME_COMPANY_TABLE WHERE $clm_com_id = ?',
        [companyId]);

    if (listOfMaps.isNotEmpty) {
      return listOfMaps
          .map((e) => CompanyModel.fromDb(e))
          .toList()
          .first;
    }
    return null;
  }

  static Future<int> deleteCompanyByCompanyId({
    required int companyId,
  }) async {
    Database? db = await DbHelper.getDataBaseInstance();
    return db!.delete(TABLE_NAME_COMPANY_TABLE,
        where: "$clm_com_id = ?", whereArgs: [companyId]);
  }

  static Future<List<CompanyModel>> getAllCompanyFromDb() async {
    Database? db = await DbHelper.getDataBaseInstance();
    final List<Map<String, dynamic>> listOfMaps =
    await db!.rawQuery('SELECT * FROM $TABLE_NAME_COMPANY_TABLE');
    if (listOfMaps.isNotEmpty) {
      return listOfMaps.map((e) => CompanyModel.fromDb(e)).toList();
    }
    return [];
  }

}