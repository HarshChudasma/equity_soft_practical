import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:equitysoft_practical/config/routes/app_routes.dart';
import 'package:equitysoft_practical/modules/category/controllers/category_controller.dart';
import 'package:equitysoft_practical/modules/category/models/category_model.dart';
import 'package:equitysoft_practical/modules/company/controllers/company_controller.dart';
import 'package:equitysoft_practical/modules/company/models/company_model.dart';
import 'package:equitysoft_practical/modules/product/controllers/product_controller.dart';
import 'package:equitysoft_practical/modules/product/models/product_model.dart';
import 'package:equitysoft_practical/modules/product/widget/common_textfield.dart';
import 'package:equitysoft_practical/utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/colors_constant.dart';
import '../../../utils/permission_utils.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _qtyController = TextEditingController();

  final FocusNode _productNameFocusNode = FocusNode();
  final FocusNode _categoryFocusNode = FocusNode();
  final FocusNode _companyFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();
  final FocusNode _priceFocusNode = FocusNode();
  final FocusNode _qtyFocusNode = FocusNode();

  ProductController productController = Get.find<ProductController>();
  CategoryController categoryController = Get.find<CategoryController>();
  CompanyController companyController = Get.find<CompanyController>();

  List<CategoryModel> _categoryModelList = [];
  List<CompanyModel> _companyModelList = [];
  var arguments;

  @override
  void initState() {
    setTextFieldFocusNode();
    removeAllImageorList();
    categoryController.getCategory();
    companyController.getCompanyDb();
    super.initState();
  }

  removeAllImageorList() {
    productController.firstImage = null;
    productController.secondImage = null;
    productController.thirdImage = null;
    productController.fourthImage = null;
    productController.imageList.clear();
  }

  void setTextFieldFocusNode() {
    _productNameFocusNode.addListener(() {
      setState(() {});
    });
    _categoryFocusNode.addListener(() {
      setState(() {});
    });
    _companyFocusNode.addListener(() {
      setState(() {});
    });
    _descriptionFocusNode.addListener(() {
      setState(() {});
    });
    _priceFocusNode.addListener(() {
      setState(() {});
    });
    _qtyFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    TargetPlatform platform = Theme.of(context).platform;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: AppColorConstants.greyColor,
        title: const Text(
          "Add Products",
          style: TextStyle(
            fontSize: 24.0,
            color: AppColorConstants.whiteColor,
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 12.0,
                  ),
                  CommonTextFieldWidget(
                    controller: _productNameController,
                    focusNode: _productNameFocusNode,
                    lableText: "Product Name",
                    textInputType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter Product Name!";
                      }
                    },
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Obx(
                    () => DropdownButtonFormField2(
                      isExpanded: true,
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black45,
                      ),
                      buttonHeight: 20,
                      onChanged: (value) {
                        categoryController.categoryModel = value!;
                      },
                      items: categoryController.categoryList.map(
                        (item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Text(
                              item.categoryName,
                            ),
                          );
                        },
                      ).toList(),
                      validator: (value){
                        if(categoryController.categoryModel == null){
                          return "Please select category";
                        }
                      },
                      focusNode: _categoryFocusNode,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        focusColor: AppColorConstants.greyColor,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 12.0),
                        isDense: true,
                        labelText: "Category",
                        labelStyle: const TextStyle(
                            color: AppColorConstants.greyColor, fontSize: 16.0),
                      ),
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Obx(
                    () => DropdownButtonFormField2(
                      isExpanded: true,
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black45,
                      ),
                      buttonHeight: 20,
                      onChanged: (value) {
                        companyController.companyModel = value!;
                      },
                      validator: (value){
                        if(companyController.companyModel == null){
                          return "Please select company";
                        }
                      },
                      items: companyController.companyList.map(
                        (item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Text(
                              item.companyName,
                            ),
                          );
                        },
                      ).toList(),
                      focusNode: _companyFocusNode,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        focusColor: AppColorConstants.greyColor,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 12.0),
                        isDense: true,
                        labelText: "Company",
                        labelStyle: const TextStyle(
                            color: AppColorConstants.greyColor, fontSize: 16.0),
                      ),
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  CommonTextFieldWidget(
                    controller: _descriptionController,
                    focusNode: _descriptionFocusNode,
                    lableText: "Description",
                    textInputType: TextInputType.multiline,
                    maximumLine: 5,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter Some Description";
                      }
                    },
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  CommonTextFieldWidget(
                    controller: _priceController,
                    focusNode: _priceFocusNode,
                    lableText: "Price",
                    textInputType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter Product Price!";
                      }
                    },
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  CommonTextFieldWidget(
                    controller: _qtyController,
                    focusNode: _qtyFocusNode,
                    lableText: "Qty",
                    textInputType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter Quntity";
                      }
                    },
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Upload Image:",
                      style: TextStyle(
                          fontSize: 14.0, color: AppColorConstants.greyColor),
                    ),
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: GetBuilder<ProductController>(
                          builder: (_) {
                            return productController.firstImage != null
                                ? Container(
                                    height: 42.0,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: AppColorConstants.greyColor,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                        5.0,
                                      ),
                                    ),
                                    child: Image.file(
                                        productController.firstImage!),
                                  )
                                : InkWell(
                                    onTap: () {
                                      _selectImageFromGallary(platform, 1);
                                    },
                                    child: Container(
                                      height: 42.0,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: AppColorConstants.greyColor,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          5.0,
                                        ),
                                      ),
                                      child: const Icon(
                                        Icons.add,
                                        size: 22,
                                      ),
                                    ),
                                  );
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      Expanded(
                        child: GetBuilder<ProductController>(
                          builder: (_) {
                            return productController.secondImage != null
                                ? Container(
                                    height: 42.0,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: AppColorConstants.greyColor,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                        5.0,
                                      ),
                                    ),
                                    child: Image.file(
                                        productController.secondImage!),
                                  )
                                : InkWell(
                                    onTap: () {
                                      _selectImageFromGallary(platform, 2);
                                    },
                                    child: Container(
                                      height: 42.0,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: AppColorConstants.greyColor,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          5.0,
                                        ),
                                      ),
                                      child: const Icon(
                                        Icons.add,
                                        size: 22,
                                      ),
                                    ),
                                  );
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      Expanded(
                        child: GetBuilder<ProductController>(
                          builder: (_) {
                            return productController.thirdImage != null
                                ? Container(
                                    height: 42.0,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: AppColorConstants.greyColor,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                        5.0,
                                      ),
                                    ),
                                    child: Image.file(
                                        productController.thirdImage!),
                                  )
                                : InkWell(
                                    onTap: () {
                                      _selectImageFromGallary(platform, 3);
                                    },
                                    child: Container(
                                      height: 42.0,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: AppColorConstants.greyColor,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          5.0,
                                        ),
                                      ),
                                      child: const Icon(
                                        Icons.add,
                                        size: 22,
                                      ),
                                    ),
                                  );
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      Expanded(
                        child: GetBuilder<ProductController>(
                          builder: (_) {
                            return productController.fourthImage != null
                                ? Container(
                                    height: 42.0,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: AppColorConstants.greyColor,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                        5.0,
                                      ),
                                    ),
                                    child: Image.file(
                                        productController.fourthImage!),
                                  )
                                : InkWell(
                                    onTap: () {
                                      _selectImageFromGallary(platform, 4);
                                    },
                                    child: Container(
                                      height: 42.0,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: AppColorConstants.greyColor,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          5.0,
                                        ),
                                      ),
                                      child: const Icon(
                                        Icons.add,
                                        size: 22,
                                      ),
                                    ),
                                  );
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Minimum 2 Image",
                      style: TextStyle(
                          fontSize: 14.0, color: AppColorConstants.greyColor),
                    ),
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        print("product image list : ${productController.imageList}");
                        if (productController.imageList.length >= 2) {
                          ProductModel productModel = ProductModel(
                            productName: _productNameController.text,
                            categoryId: categoryController.categoryModel!.id,
                            companyId: companyController.companyModel!.id,
                            productCategory: categoryController.categoryModel!.categoryName,
                            productCompany: companyController.companyModel!.companyName,
                            productDesc: _descriptionController.text,
                            productPrice: _priceController.text,
                            productQty: _qtyController.text,
                            productImages: productController.imageList,
                          );
                          productController.addProducttoDb(productModel);
                          emptyAllField();
                          Get.back();
                          // Get.offNamed(AppRoutes.PRODUCT_LIST_SCREEN);
                        } else {
                          Utility.showToast("Please select minimum 2 image");
                        }
                        FocusScope.of(context).unfocus();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColorConstants.greyColor,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                      child: Text(
                        "Save",
                        style: TextStyle(
                            color: AppColorConstants.whiteColor,
                            fontSize: 14.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void emptyAllField(){
    _productNameController.text = "";
    categoryController.categoryModel = null;
    companyController.companyModel = null;
    _descriptionController.text = "";
    _priceController.text = "";
    _qtyController.text = "";
    productController.firstImage = null;
    productController.secondImage = null;
    productController.thirdImage = null;
    productController.fourthImage = null;
    productController.imageList.clear();
  }

  void _selectImageFromGallary(TargetPlatform platform, int value) {
    PermissionUtil.checkPermission(platform).then(
      (isGranted) async {
        if (isGranted != null && isGranted) {
          productController.selectImage(value);
        } else {
          print('perimssion nont granted...........');
        }
      },
    );
  }

  @override
  void dispose() {
    _categoryController.dispose();
    _companyController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _qtyController.dispose();
    _productNameFocusNode.dispose();
    _categoryFocusNode.dispose();
    _companyFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _priceFocusNode.dispose();
    _qtyFocusNode.dispose();
    super.dispose();
  }
}
