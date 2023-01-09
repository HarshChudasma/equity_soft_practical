import 'dart:convert';
import 'dart:io';

import 'package:equitysoft_practical/database/productlist_tbl.dart';
import 'package:equitysoft_practical/modules/category/models/category_drop_down_model.dart';
import 'package:equitysoft_practical/modules/category/models/category_model.dart';
import 'package:equitysoft_practical/modules/product/models/product_model.dart';
import 'package:equitysoft_practical/utils/utility.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProductController extends GetxController {
  late RxList<ProductModel> productModelList = RxList<ProductModel>();
  late RxList<String> imageList = RxList<String>();
  ProductModel? productModel;
  final RxBool isLoading = true.obs;
  final RxBool isError = false.obs;
  final RxBool isAddLoad = true.obs;
  final RxBool isAddError = false.obs;

  final RxBool isEdit = false.obs;
  final RxInt isId = 0.obs;

  File? firstImage;
  File? secondImage;
  File? thirdImage;
  File? fourthImage;

  final picker = ImagePicker();
  late File image;

  //For Product Details
  final RxBool isLoadingProductDetails = true.obs;
  final RxBool hasErrorProductDetails = false.obs;

  // for edit value
  final RxBool isEditLoad = true.obs;
  final RxBool isEditError = false.obs;



  Future<void> selectImage(int value) async {
    String img64;
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    image = File(pickedFile!.path);
    final byt = image.readAsBytesSync().lengthInBytes;
    final kb = byt / 1024;
    final mb = kb / 1024;
    if (mb <= 1) {
      if (value == 1) {
        firstImage = image;
        update();
      } else if (value == 2) {
        secondImage = image;
        update();
      } else if (value == 3) {
        thirdImage = image;
        update();
      } else if (value == 4) {
        fourthImage = image;
        update();
      }
      final bytes = File(image.path).readAsBytesSync();
      img64 = base64Encode(bytes);
      imageList.add(img64);
    } else {
      Utility.showToast("Image is more than 1 MB");
    }
  }

  void addNewProduct({required ProductModel productModel}) async {
    isAddLoad.value = true;
    isAddError.value = false;
    try {
      await ProductListTable.addNewProduct(productModel: productModel);
      isAddLoad.value = false;
      isAddError.value = false;
      getProductDb();
      return;
    } catch (error) {
      isAddLoad.value = false;
      isAddError.value = true;
      return;
    }
  }

  void getProductDb() {
    try {
      isLoading.value = true;
      isError.value = false;
      ProductListTable.getAllProductFromDb().then(
        (value) {
          productModelList.value = value;
          isLoading.value = false;
          isError.value = false;
        },
      );
    } catch (error) {
      isError.value = true;
      isLoading.value = false;
    }
  }

  Future<void> getProductByIdDb({required int productId}) async {
    try {
      isLoadingProductDetails.value = true;
      hasErrorProductDetails.value = false;
      productModel =
          await ProductListTable.getProductById(productId: productId);
      isLoadingProductDetails.value = false;
      hasErrorProductDetails.value = false;
      return;
    } catch (error) {
      isLoadingProductDetails.value = false;
      hasErrorProductDetails.value = true;
      return;
    }
  }

  void updateProductByIdDb({required ProductModel productModel,required int productid}) async {
    try {
      isEditLoad.value = true;
      isEditError.value = false;
      await ProductListTable.updateProductNew(productModel: productModel,productid: productid);
      isLoadingProductDetails.value = false;
      hasErrorProductDetails.value = false;
      getProductDb();
      return;
    } catch (error) {
      Utility.showToast(error.toString());
      isLoadingProductDetails.value = false;
      hasErrorProductDetails.value = true;
      return;
    }
  }



  void deleteProductById(int productId) {
    ProductListTable.deleteProductByProductId(productId: productId).then(
      (value) {
        getProductDb();
      },
    );
  }
}
