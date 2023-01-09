import 'package:equitysoft_practical/database/category_tbl.dart';
import 'package:equitysoft_practical/modules/category/models/category_drop_down_model.dart';
import 'package:equitysoft_practical/modules/category/models/category_model.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  final RxList<CategoryModel> categoryList = RxList<CategoryModel>([]);
  final RxBool isLoading = true.obs;
  final RxBool isError = false.obs;
  final RxBool isAddLoad = true.obs;
  final RxBool isAddError = false.obs;
  CategoryModel? categoryModel;

  //for product category drop down
  late RxList<CategoryDropDownModel> categoryModelDropDownList = RxList<CategoryDropDownModel>([]);
  late RxInt selectedCategoryPos = 0.obs;

  getCategory() {
    isLoading.value = true;
    try{
      categoryModelDropDownList.clear();
      CategoryTable.getAllCategoryFromDb().then(
            (value) {
          categoryList.value = value;
          for(int i=0;i<categoryList.length;i++){
            CategoryDropDownModel categoryModelDropDownLis = CategoryDropDownModel(position: i,categoryName: categoryList[i].categoryName,categoryId: categoryList[i].id,);
            categoryModelDropDownList.add(categoryModelDropDownLis);
          }
          isLoading.value = false;
        },
      );
    } catch(error){
      isError.value = true;
      isLoading.value = false;
    }
  }

  addCategorytoDb(CategoryModel categoryModel){
    isAddLoad.value = true;
    try{
      CategoryTable.addNewCategory(categoryModel: categoryModel).then((value) {
        isAddLoad.value = false;
        getCategory();
      });

    } catch(error){
      isAddError.value = true;
      isAddLoad.value = false;
    }
  }

  deleteCategoryFromDb(int categoryId,int index){
    CategoryTable.deleteCategoryByCategoryId(categoryId: categoryId).then((value) {
      categoryList.remove(index);
      getCategory();
    });
  }

}
