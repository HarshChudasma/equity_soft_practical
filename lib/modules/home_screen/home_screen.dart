import 'package:equitysoft_practical/constants/colors_constant.dart';
import 'package:equitysoft_practical/modules/category/controllers/category_controller.dart';
import 'package:equitysoft_practical/modules/company/controllers/company_controller.dart';
import 'package:equitysoft_practical/modules/product/controllers/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/routes/app_routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    Get.put<CategoryController>(CategoryController(), permanent: true);
    Get.put<CompanyController>(CompanyController(),permanent: true);
    Get.put<ProductController>(ProductController(),permanent: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: AppColorConstants.greyColor,
        elevation: 0.0,
        centerTitle: true,
        title: const Text(
          "Home",
          style: TextStyle(
            fontSize: 24.0,
            color: AppColorConstants.whiteColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _homePageCommonButton(
                "Products",
                () {
                  Get.toNamed(AppRoutes.PRODUCT_LIST_SCREEN);
                },
              ),
              const SizedBox(
                height: 12.0,
              ),
              _homePageCommonButton(
                "Manage Category",
                () {
                  Get.toNamed(AppRoutes.ADD_CATEGORY_SCREEN);
                },
              ),
              const SizedBox(
                height: 12.0,
              ),
              _homePageCommonButton(
                "Manage Company",
                () {
                  Get.toNamed(AppRoutes.ADD_COMPANY_SCREEN);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _homePageCommonButton(String lable, Function onTap) {
    Size size = MediaQuery.of(context).size;

    return InkWell(
      onTap: () => onTap(),
      child: Container(
        width: size.width,
        height: size.height * 0.25,
        decoration: BoxDecoration(
          color: AppColorConstants.greyColor,
          borderRadius: BorderRadius.circular(5.0),
        ),
        alignment: Alignment.center,
        child: Text(
          lable,
          style: const TextStyle(
            fontSize: 22.0,
            color: AppColorConstants.whiteColor,
          ),
        ),
      ),
    );
  }
}
