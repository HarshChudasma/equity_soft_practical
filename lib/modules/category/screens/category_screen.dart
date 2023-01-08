import 'package:equitysoft_practical/constants/colors_constant.dart';
import 'package:equitysoft_practical/database/category_tbl.dart';
import 'package:equitysoft_practical/modules/category/controllers/category_controller.dart';
import 'package:equitysoft_practical/modules/category/models/category_model.dart';
import 'package:equitysoft_practical/modules/product/widget/common_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({super.key});

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  CategoryController categoryController = Get.find<CategoryController>();

  final TextEditingController _categoryTextEditingController =
      TextEditingController();

  final FocusNode _categoryFocusNode = FocusNode();

  @override
  void initState() {
    setTextFieldFocusNode();
    categoryController.getCategory();
    super.initState();
  }

  void setTextFieldFocusNode() {
    _categoryFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: AppColorConstants.greyColor,
        title: const Text(
          "Category",
          style: TextStyle(
            fontSize: 24.0,
            color: AppColorConstants.whiteColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 12.0,
                ),
                CommonTextFieldWidget(
                  controller: _categoryTextEditingController,
                  focusNode: _categoryFocusNode,
                  lableText: "Category Name",
                  textInputType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter Category Name";
                    }
                  },
                ),
                const SizedBox(
                  height: 16.0,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      CategoryModel categoryModel = CategoryModel(categoryName: _categoryTextEditingController.text);
                      categoryController.addCategorytoDb(categoryModel);
                      _categoryTextEditingController.text = "";
                      FocusScope.of(context).unfocus();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColorConstants.greyColor,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    child: Text(
                      "Add",
                      style: TextStyle(
                          color: AppColorConstants.whiteColor, fontSize: 14.0),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24.0,
                ),
                const Text(
                  "List of categories",
                  style: TextStyle(
                      color: AppColorConstants.greyColor, fontSize: 14.0),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Obx(() => Expanded(
                  child: categoryController.isLoading.value ? Container(
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(
                      color: AppColorConstants.greyColor,
                    ),
                  ) : categoryController.categoryList.isEmpty
                      ? Container(
                    alignment: Alignment.center,
                    child: const Text(
                      "No Data Found!",
                      style: TextStyle(
                          color: AppColorConstants.greyColor,
                          fontSize: 24.0),
                    ),
                  )
                      : ListView.builder(
                    itemCount: categoryController.categoryList.length,
                    itemBuilder: (context, index) {
                      return _listOfCategory(index);
                    },
                  ),
                ),),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _listOfCategory(int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: AppColorConstants.greyColor,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              categoryController.categoryList[index].categoryName,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: AppColorConstants.whiteColor,
                fontSize: 18.0,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              categoryController.deleteCategoryFromDb(categoryController.categoryList[index].id, index);
            },
            child: Icon(
              Icons.delete_outline_outlined,
              color: AppColorConstants.whiteColor,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _categoryTextEditingController.dispose();
    _categoryFocusNode.dispose();
    super.dispose();
  }
}
