import 'package:carousel_slider/carousel_slider.dart';
import 'package:equitysoft_practical/database/productlist_tbl.dart';
import 'package:equitysoft_practical/modules/product/controllers/product_controller.dart';
import 'package:equitysoft_practical/modules/product/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/colors_constant.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  ProductController productController = Get.find<ProductController>();

  List imgList = [
    'https://i.dlpng.com/static/png/6838599_preview.png',
    'https://i.dlpng.com/static/png/6838599_preview.png',
    'https://i.dlpng.com/static/png/6838599_preview.png',
    'https://i.dlpng.com/static/png/6838599_preview.png',
  ];
  RxInt _current = 0.obs;

  var productArguments;
  ProductModel? productModel;

  @override
  void initState() {
    productArguments = Get.arguments;
    productController.getProductByIdDb(productArguments['id']);
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
          "Detail Screen",
          style: TextStyle(
            fontSize: 24.0,
            color: AppColorConstants.whiteColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        child: Obx(() => productController.isLoading.value ? Container(
          alignment: Alignment.center,
          child: const CircularProgressIndicator(
            color: AppColorConstants.greyColor,
          ),
        ) : Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    height: 200.0,
                    initialPage: 0,
                    reverse: false,
                    autoPlay: true,
                    enableInfiniteScroll: false,
                    scrollDirection: Axis.horizontal,
                    onPageChanged: (index, fn) {
                      _current = index as RxInt;
                    },
                  ),
                  items: imgList.map((imgUrl) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            color: AppColorConstants.whiteColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Image.network(
                            imgUrl,
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
            const SizedBox(
              height: 24.0,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 6,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                productController.productModel!.value.productName,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: AppColorConstants.greyColor,
                                    fontSize: 14.0),
                              ),
                              const SizedBox(
                                height: 4.0,
                              ),
                              Text(
                                productController.productModel!.value.productCategory,
                                style: const TextStyle(
                                    color: AppColorConstants.greyColor,
                                    fontSize: 10.0),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Text(
                            "Price: ${productController.productModel!.value.productPrice}",
                            style: const TextStyle(
                                color: AppColorConstants.greyColor,
                                fontSize: 14.0),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 6,
                          child: Text(
                            productModel!.productCompany,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: AppColorConstants.greyColor,
                                fontSize: 14.0),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Text(
                            "Qty: ${productController.productModel!.value.productQty}",
                            style: const TextStyle(
                                color: AppColorConstants.greyColor,
                                fontSize: 14.0),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    const Text(
                      "Description:",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: AppColorConstants.greyColor, fontSize: 14.0),
                    ),
                    const SizedBox(
                      height: 6.0,
                    ),
                    Text(
                      productController.productModel!.value.productDescription,
                      style: const TextStyle(
                          color: AppColorConstants.greyColor, fontSize: 12.0),
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {

                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColorConstants.greyColor,
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 12.0),
                              child: Text(
                                "Edit",
                                style: TextStyle(
                                    color: AppColorConstants.whiteColor,
                                    fontSize: 14.0),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 24.0,
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              productController.deleteProductById(productArguments['id'], productArguments['index']);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColorConstants.greyColor,
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 12.0),
                              child: Text(
                                "Delete",
                                style: TextStyle(
                                    color: AppColorConstants.whiteColor,
                                    fontSize: 14.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ), ),


      ),
    );
  }
}
