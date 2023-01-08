import 'package:equitysoft_practical/config/routes/app_routes.dart';
import 'package:equitysoft_practical/modules/category/screens/add_category_screen.dart';
import 'package:equitysoft_practical/modules/company/add_company_screen.dart';
import 'package:equitysoft_practical/modules/home_screen/home_screen.dart';
import 'package:equitysoft_practical/modules/product/add_product_screen.dart';
import 'package:equitysoft_practical/modules/product_details/product_detail_screen.dart';
import 'package:equitysoft_practical/modules/product_screen/product_screen.dart';
import 'package:equitysoft_practical/modules/splash_screen/splash_screen.dart';
import 'package:get/get.dart';

class AppScreens {
  static var list = [
    GetPage(
      name: AppRoutes.SPLASH_SCREEN,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: AppRoutes.HOME_SCREEN,
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: AppRoutes.PRODUCT_LIST_SCREEN,
      page: () => const ProductListScreen(),
    ),
    GetPage(
      name: AppRoutes.ADD_PRODUCT_SCREEN,
      page: () => const AddProductScreen(),
    ),
    GetPage(
      name: AppRoutes.DETAILS_SCREEN,
      page: () => const ProductDetailsScreen(),
    ),
    GetPage(
      name: AppRoutes.ADD_CATEGORY_SCREEN,
      page: () => const AddCategoryScreen(),
    ),
    GetPage(
      name: AppRoutes.ADD_COMPANY_SCREEN,
      page: () => const AddCompanyScreen(),
    ),
  ];
}
