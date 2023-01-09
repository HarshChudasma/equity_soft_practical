import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:equitysoft_practical/modules/category/controllers/category_controller.dart';
import 'package:equitysoft_practical/modules/company/controllers/company_controller.dart';
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

  var arguments;

  @override
  void initState() {
    setTextFieldFocusNode();
    removeAllImageorList();
    arguments = Get.arguments;
    categoryController.selectedCategoryPos.value = 0;
    companyController.selectedCompanyPos.value = 0;
    productController.isEdit.value = false;
    if (arguments != null) {
      print("${arguments['isEdit']}");
      productController.isEdit.value = arguments['isEdit'];
      productController.isId.value = arguments['id'];
      if (arguments['isEdit'] == true) {
        productController.getProductByIdDb(productId: arguments['id']).then((value) {
          setEditValue();
        });
      }
    }
    categoryController.getCategory();
    companyController.getCompanyDb();
    super.initState();
  }

  setEditValue() {
    _productNameController.text = productController.productModel!.productName;
    _descriptionController.text =
        productController.productModel!.productDescription;
    _priceController.text = productController.productModel!.productPrice;
    _qtyController.text = productController.productModel!.productQty;
    for (int i = 0;
        i < categoryController.categoryModelDropDownList.length;
        i++) {
      if (categoryController.categoryModelDropDownList[i].categoryId ==
          productController.productModel!.categoryId) {
        categoryController.selectedCategoryPos.value = i;
      }
    }
    for (int i = 0;
        i < companyController.companyDropDownModelList.length;
        i++) {
      if (companyController.companyDropDownModelList[i].companyId ==
          productController.productModel!.companyId) {
        companyController.selectedCompanyPos.value = i;
      }
    }
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
                      value: categoryController.selectedCategoryPos.value,
                      onChanged: (position) {
                        categoryController.selectedCategoryPos.value =
                            position as int;
                      },
                      iconEnabledColor: Colors.blue,
                      isDense: true,
                      isExpanded: true,
                      items: [
                        ...categoryController.categoryModelDropDownList
                            .map(
                              (e) => DropdownMenuItem(
                                value: e.position,
                                child: Text(e.categoryName),
                              ),
                            )
                            .toList(),
                      ],
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black45,
                      ),
                      buttonHeight: 20,
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
                      value: companyController.selectedCompanyPos.value,
                      onChanged: (position) {
                        companyController.selectedCompanyPos.value =
                            position as int;
                      },
                      iconEnabledColor: Colors.blue,
                      isDense: true,
                      isExpanded: true,
                      items: [
                        ...companyController.companyDropDownModelList
                            .map(
                              (e) => DropdownMenuItem(
                                value: e.position,
                                child: Text(e.companyName),
                              ),
                            )
                            .toList(),
                      ],
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black45,
                      ),
                      buttonHeight: 20,
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
                  Obx(
                    () => ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          if (productController.isEdit.value == true) {
                            updateProduct();
                          } else {
                            addProduct();
                          }

                          FocusScope.of(context).unfocus();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColorConstants.greyColor,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 12.0),
                        child: Text(
                          productController.isEdit.value ? "Update" : "Save",
                          style: const TextStyle(
                              color: AppColorConstants.whiteColor,
                              fontSize: 14.0),
                        ),
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

  void addProduct() {
    if (productController.imageList.length >= 1) {
      ProductModel productModel = ProductModel(
        productName: _productNameController.text,
        categoryId: categoryController
            .categoryModelDropDownList[
                categoryController.selectedCategoryPos.value]
            .categoryId,
        companyId: companyController
            .companyDropDownModelList[
                companyController.selectedCompanyPos.value]
            .companyId,
        productCategory: categoryController
            .categoryModelDropDownList[
                categoryController.selectedCategoryPos.value]
            .categoryName,
        productCompany: companyController
            .companyDropDownModelList[
                companyController.selectedCompanyPos.value]
            .companyName,
        productDesc: _descriptionController.text,
        productPrice: _priceController.text,
        productQty: _qtyController.text,
        productImages: [productController.imageList.first],
      );
      productController.addNewProduct(
        productModel: productModel,
      );
      emptyAllField();
      Get.back();
    } else {
      Utility.showToast("Please select minimum 1 image");
    }
  }

  void updateProduct() {
    if (productController.imageList.length >= 1) {
      ProductModel productModel = ProductModel(
        productName: _productNameController.text,
        categoryId: categoryController
            .categoryModelDropDownList[
                categoryController.selectedCategoryPos.value]
            .categoryId,
        companyId: companyController
            .companyDropDownModelList[
                companyController.selectedCompanyPos.value]
            .companyId,
        productCategory: categoryController
            .categoryModelDropDownList[
                categoryController.selectedCategoryPos.value]
            .categoryName,
        productCompany: companyController
            .companyDropDownModelList[
                companyController.selectedCompanyPos.value]
            .companyName,
        productDesc: _descriptionController.text,
        productPrice: _priceController.text,
        productQty: _qtyController.text,
        productImages: [productController.imageList.first],
      );
      productController.updateProductByIdDb(
          productModel: productModel, productid: productController.isId.value);
      emptyAllField();
      Get.back();
    } else {
      Utility.showToast("Please select minimum 1 image");
    }
  }

  void emptyAllField() {
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
