import 'dart:convert';

class ProductModel {
  late int _id;
  late String _productName;
  late int _categoryId;
  late String _productCategory;
  late int _companyId;
  late String _productCompany;
  late String _productDescription;
  late String _productPrice;
  late String _productQty;
  late List<String> _productImages;

  int get id => _id;

  int get categoryId => _categoryId;

  int get companyId => _companyId;

  String get productName => _productName;

  String get productCategory => _productCategory;

  String get productCompany => _productCompany;

  String get productDescription => _productDescription;

  String get productPrice => _productPrice;

  String get productQty => _productQty;

  List<String> get productImages => _productImages;

  // set setProductName(String productName) => _productName = productName;
  //
  // set setCategoryId(int categoryId) => _categoryId = categoryId;
  //
  // set setCompanyId(int companyId) => _companyId = companyId;
  //
  // set setProductCategory(String productCategory) =>
  //     _productCategory = productCategory;
  //
  // set setProductCompany(String productCompany) =>
  //     _productCompany = productCompany;
  //
  // set setProductDescription(String productDescription) =>
  //     _productDescription = productDescription;
  //
  // set setProductPrice(String productPrice) => _productPrice = productPrice;
  //
  // set setProductQty(String productQty) => _productQty = productQty;

  ProductModel({
    required String productName,
    required int categoryId,
    required int companyId,
    required String productCategory,
    required String productCompany,
    required String productDesc,
    required String productPrice,
    required String productQty,
    required List<String> productImages,
  }) {
    _productName = productName;
    _categoryId = categoryId;
    _companyId = companyId;
    _productCategory = productCategory;
    _productCompany = productCompany;
    _productDescription = productDesc;
    _productPrice = productPrice;
    _productQty = productQty;
    _productImages = productImages;
  }

  ProductModel.fromDb(Map<String, dynamic> json) {
    _id = json['id'];
    _categoryId = json['category_id'];
    _companyId = json['company_id'];
    _productName = json['product_name'];
    _productCategory = json['category_name'];
    _productCompany = json['company_name'];
    _productDescription = json['description'];
    _productPrice = json['price'];
    _productQty = json['qty'];
    _productImages = [];
    if (json['product_img'] != null) {
      _productImages = jsonDecode(json['product_img']).cast<String>();
    }
  }

  Map<String, dynamic> toMapForCategoryDb() {
    return <String, dynamic>{
      'product_name': _productName,
      'category_id': _categoryId,
      'company_id': _companyId,
      'category_name': _productCategory,
      'company_name': _productCompany,
      'description': _productDescription,
      'price': _productPrice,
      'product_img': _productImages.isEmpty
          ? jsonEncode([])
          : jsonEncode(
              _productImages,
            ),
      'qty': _productQty
    };
  }
}
