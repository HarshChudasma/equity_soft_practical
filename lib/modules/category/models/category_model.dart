class CategoryModel {
  late int _id;
  late String _categoryName;

  int get id => _id;

  String get categoryName => _categoryName;

  set setCategoryName(String categoryName) => _categoryName = categoryName;

  CategoryModel({required String categoryName}) {
    _categoryName = categoryName;
  }

  CategoryModel.fromDb(Map<String, dynamic> json) {
    _id = json['id'];
    _categoryName = json['cate_name'];
  }

  Map<String, dynamic> toMapForCategoryDb() {
    return <String, dynamic>{
      'cate_name': _categoryName,
    };
  }
}
