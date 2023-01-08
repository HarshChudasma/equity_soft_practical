class CompanyModel {
  late int _id;
  late String _companyName;

  int get id => _id;

  String get companyName => _companyName;

  set setCompanyName(String categoryName) => _companyName = companyName;

  CompanyModel({required String companyName}) {
    _companyName = companyName;
  }

  CompanyModel.fromDb(Map<String, dynamic> json) {
    _id = json['id'];
    _companyName = json['company_name'];
  }

  Map<String, dynamic> toMapForCategoryDb() {
    return <String, dynamic>{
      'company_name': _companyName,
    };
  }
}
