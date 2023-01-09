import 'package:carousel_slider/carousel_slider.dart';
import 'package:equitysoft_practical/config/routes/app_routes.dart';
import 'package:equitysoft_practical/modules/product/controllers/product_controller.dart';
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

  @override
  void initState() {
    int productId = Get.arguments as int;
    productController.getProductByIdDb(productId: productId);
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
      body: Obx(
        () => productController.isLoadingProductDetails.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : productController.hasErrorProductDetails.value
                ? const Center(
                    child: Text(
                      'Something went wrong, Please try again later!',
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 16.0),
                    child: Column(
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
                                  // _current = index as RxInt;
                                },
                              ),
                              items: imgList.map((imgUrl) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return Container(
                                      width: MediaQuery.of(context).size.width,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            productController
                                                .productModel!.productName,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                color:
                                                    AppColorConstants.greyColor,
                                                fontSize: 14.0),
                                          ),
                                          const SizedBox(
                                            height: 4.0,
                                          ),
                                          Text(
                                            productController
                                                .productModel!.productCategory,
                                            style: const TextStyle(
                                                color:
                                                    AppColorConstants.greyColor,
                                                fontSize: 10.0),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 4,
                                      child: Text(
                                        "Price: ${productController.productModel!.productPrice}",
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
                                        productController
                                            .productModel!.productCompany,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            color: AppColorConstants.greyColor,
                                            fontSize: 14.0),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 4,
                                      child: Text(
                                        "Qty: ${productController.productModel!.productQty}",
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
                                      color: AppColorConstants.greyColor,
                                      fontSize: 14.0),
                                ),
                                const SizedBox(
                                  height: 6.0,
                                ),
                                Text(
                                  productController
                                      .productModel!.productDescription,
                                  style: const TextStyle(
                                      color: AppColorConstants.greyColor,
                                      fontSize: 12.0),
                                ),
                                const SizedBox(
                                  height: 24.0,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Get.toNamed(
                                            AppRoutes.ADD_PRODUCT_SCREEN,
                                            arguments: {
                                              "isEdit": true,
                                              "id": productController
                                                  .productModel!.id
                                            },
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              AppColorConstants.greyColor,
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 12.0),
                                          child: Text(
                                            "Edit",
                                            style: TextStyle(
                                                color: AppColorConstants
                                                    .whiteColor,
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
                                          productController.deleteProductById(productController
                                              .productModel!.id);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              AppColorConstants.greyColor,
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 12.0),
                                          child: Text(
                                            "Delete",
                                            style: TextStyle(
                                                color: AppColorConstants
                                                    .whiteColor,
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
                    )),
      ),
    );
  }
}
