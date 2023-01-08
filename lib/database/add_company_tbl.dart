class CompanyTable{
  static const String TABLE_NAME_COMPANY_TABLE = "companyList";
  static const String com_id = "id";
  static const String com_name = "comName";

  static const CREATE_TABLE_COMPANY_LIST =
  """CREATE TABLE $TABLE_NAME_COMPANY_TABLE(
      $com_id integer primary key,
      $com_name text,
      )""";

}