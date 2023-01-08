import 'dart:convert';
import 'dart:io';

import 'package:equitysoft_practical/database/productlist_tbl.dart';
import 'package:equitysoft_practical/modules/product/models/product_model.dart';
import 'package:equitysoft_practical/utils/utility.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProductController extends GetxController{
  late RxList<ProductModel> productModelList = RxList<ProductModel>();
  late RxList<String> imageList = RxList<String>();
  Rx<ProductModel>? productModel;
  final RxBool isLoading = true.obs;
  final RxBool isError = false.obs;
  final RxBool isAddLoad = true.obs;
  final RxBool isAddError = false.obs;
  File? firstImage;
  File? secondImage;
  File? thirdImage;
  File? fourthImage;

  final picker = ImagePicker();
  late File image;

  Future<void> selectImage(int value) async {
    String img64;
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    image = File(pickedFile!.path);
    final byt = image.readAsBytesSync().lengthInBytes;
    final kb = byt / 1024;
    final mb = kb / 1024;
    if(mb <= 1){
      if(value == 1){
        firstImage = image;
        update();
      } else if(value == 2){
        secondImage = image;
        update();
      } else if(value == 3){
        thirdImage = image;
        update();
      } else if(value == 4){
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

  addProducttoDb(ProductModel productModel){
    isAddLoad.value = true;
    try{
      ProductListTable.addNewProduct(productModel: productModel).then((value) {
        isAddLoad.value = false;
        getProductDb();
      });
    } catch(error){
      isAddError.value = true;
      isAddLoad.value = false;
    }
  }

  getProductDb(){
    isLoading.value = true;
    try{
      ProductListTable.getAllProductFromDb().then(
            (value) {
          productModelList.value = value;
          isLoading.value = false;
        },
      );
    } catch(error){
      isError.value = true;
      isLoading.value = false;
    }
  }

  getProductByIdDb(int productId){
    isLoading.value = true;
    try{
      ProductListTable.getProductById(productId: productId).then(
            (value) {
              isLoading.value = false;
              productModel!.value = value!;

        },
      );
    } catch(error){
      isError.value = true;
      isLoading.value = false;
    }
  }

  deleteProductById(int productId,int index){
    ProductListTable.deleteProductByProductId(productId: productId).then((value) {
      productModelList.remove(index);
      getProductDb();
    });
  }


}