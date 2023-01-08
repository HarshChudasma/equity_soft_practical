import 'dart:convert';

import 'package:equitysoft_practical/modules/product/controllers/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/routes/app_routes.dart';
import '../../constants/colors_constant.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  ProductController productController = Get.find<ProductController>();

  @override
  void initState() {
    productController.getProductDb();
    super.initState();
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
          "Products",
          style: TextStyle(
            fontSize: 24.0,
            color: AppColorConstants.whiteColor,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(AppRoutes.ADD_PRODUCT_SCREEN);
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
        child: Obx(() => productController.isLoading.value ? Container(
          alignment: Alignment.center,
          child: const CircularProgressIndicator(
            color: AppColorConstants.greyColor,
          ),
        ) : productController.productModelList.isEmpty
            ? Container(
          alignment: Alignment.center,
          child: const Text(
            "No Data Found!",
            style: TextStyle(
                color: AppColorConstants.greyColor, fontSize: 24.0),
          ),
        )
            : ListView.builder(
          itemCount: productController.productModelList.length,
          itemBuilder: (context, index) {
            return _listOfProductListWidget(index);
          },
        ), ),

      ),
    );
  }

  Widget _listOfProductListWidget(int index) {
    print("product list : ${productController.productModelList[index].productImages.length}");
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.DETAILS_SCREEN,arguments: {'id': productController.productModelList[index].id,'index':index});
      },
      child: Card(
        elevation: 2.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 75,
                width: 75,
                decoration: BoxDecoration(
                  color: AppColorConstants.greyColor,
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              const SizedBox(
                width: 12.0,
              ),
              Expanded(
                flex: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      productController.productModelList[index].productCompany,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: AppColorConstants.greyColor, fontSize: 14.0),
                    ),
                    const SizedBox(
                      height: 4.0,
                    ),
                    Text(
                      productController.productModelList[index].productCategory,
                      style: const TextStyle(
                          color: AppColorConstants.greyColor, fontSize: 10.0),
                    ),
                    const SizedBox(
                      height: 4.0,
                    ),
                    Text(
                      "Qty : ${productController.productModelList[index].productQty}",
                      style: const TextStyle(
                          color: AppColorConstants.greyColor, fontSize: 12.0),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 6.0,
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Get.toNamed(
                          AppRoutes.ADD_PRODUCT_SCREEN,
                          arguments: {
                            "isEdit": true,
                            "id": productController.productModelList[index].id
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColorConstants.greyColor,
                        minimumSize: const Size(75, 28),
                      ),
                      child: const Text(
                        "Edit",
                        style: TextStyle(
                            color: AppColorConstants.whiteColor,
                            fontSize: 14.0),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        productController.deleteProductById(productController.productModelList[index].id, index);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColorConstants.greyColor,
                        minimumSize: const Size(75, 28),
                      ),
                      child: const Text(
                        "Delete",
                        style: TextStyle(
                            color: AppColorConstants.whiteColor,
                            fontSize: 14.0),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
