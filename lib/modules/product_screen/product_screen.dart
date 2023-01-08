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
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return _listOfProductListWidget();
          },
        ),
      ),
    );
  }

  Widget _listOfProductListWidget() {
    return GestureDetector(
      onTap: (){
        Get.toNamed(AppRoutes.DETAILS_SCREEN);
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
                  children: const [
                    Text(
                      "LCS Mobile Accessries New Updated",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: AppColorConstants.greyColor, fontSize: 14.0),
                    ),
                    SizedBox(
                      height: 4.0,
                    ),
                    Text(
                      "Computer & Accesseries",
                      style: TextStyle(
                          color: AppColorConstants.greyColor, fontSize: 10.0),
                    ),
                    SizedBox(
                      height: 4.0,
                    ),
                    Text(
                      "Qty : 10",
                      style: TextStyle(
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
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColorConstants.greyColor,
                        minimumSize: const Size(75, 28),
                      ),
                      child: const Text(
                        "Edit",
                        style: TextStyle(
                            color: AppColorConstants.whiteColor, fontSize: 14.0),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColorConstants.greyColor,
                        minimumSize: const Size(75, 28),
                      ),
                      child: const Text(
                        "Delete",
                        style: TextStyle(
                            color: AppColorConstants.whiteColor, fontSize: 14.0),
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
