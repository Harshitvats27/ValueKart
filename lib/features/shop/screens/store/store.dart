import 'package:e_commerce_application/common/layout/grid_layout.dart';
import 'package:e_commerce_application/common/widgets/appbar/appbar.dart';
import 'package:e_commerce_application/common/widgets/custom_shape/rounded_container.dart';
import 'package:e_commerce_application/common/widgets/images/rounded_image.dart';
import 'package:e_commerce_application/common/widgets/products/cart/cart_counter_icon.dart';
import 'package:e_commerce_application/common/widgets/products/product_cards/product_cards_vertical.dart';
import 'package:e_commerce_application/common/widgets/text/brand_title_with_verify_icon.dart';
import 'package:e_commerce_application/common/widgets/text/section_heading.dart';
import 'package:e_commerce_application/features/shop/screens/brands/all_brands.dart';
import 'package:e_commerce_application/features/shop/screens/store/widgets/category_tab.dart';
import 'package:e_commerce_application/features/shop/screens/store/widgets/store_primary_header.dart';
import 'package:e_commerce_application/utils/constants/colors.dart';
import 'package:e_commerce_application/utils/helpers/device_helpers.dart';
import 'package:e_commerce_application/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../../common/widgets/appbar/tabbar.dart';
import '../../../../common/widgets/brands/brand_cards.dart';
import '../../../../common/widgets/brands/brand_showcase.dart';
import '../../../../common/widgets/shimmer/brand_shimmer.dart';
import '../../../../common/widgets/textfields/search_bar.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/constants/images.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controllers/brand/brand_controller.dart';
import '../../controllers/categories/category_controller.dart';
import '../home/widgets/home_app_bar.dart';
import '../home/widgets/home_categories.dart';
import '../../../../common/widgets/custom_shape/primary_header_container.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryController());
    final brandController = Get.put(BrandController());
    final dark = UHelperfunctions.isDarkTheme(context);
    return DefaultTabController(
      length:controller.featuredCategories.length,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                expandedHeight: 340,
                floating: false,
                pinned: true,
                // snap: true,
                flexibleSpace: SingleChildScrollView(
                  child: Column(
                    children: [
                      UStorePrimaryHeader(),
                      SizedBox(height: USizes.spaceBtwItems),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: USizes.defaultSpace,
                        ),
                        child: Column(
                          children: [
                            /// brand heading
                            USectionHeading(title: 'Brands', onPressed: ()=>Get.to(()=>AllBrandsScreen())),

                            // round card
                            SizedBox(
                              height: 70,
                              child: Obx(
                                  (){

                                    if(brandController.isLoading.value){
                                      return UBrandsShimmer();
                                    }
                                    if(brandController.featuredBrands.isEmpty){
                                      return Center(child: Text('No Brands Found'));
                                    }
                                    return ListView.separated(
                                      separatorBuilder: (context, index) =>
                                          SizedBox(width: USizes.spaceBtwItems),

                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: brandController.featuredBrands.length,
                                      itemBuilder: (context, index)  {
                                        final brand = brandController.featuredBrands[index];

                                        return SizedBox(
                                          width: USizes.brandCardWidth,
                                          child: UBrandCard(brand: brand),
                                        );
                                      }
                                  );
                                  }
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                bottom: UTabBar(
                  tabs: controller.featuredCategories.map((category) => Tab(child: Text(category.name))).toList(),
                ),
              ),
            ];
          },
          body: TabBarView(
            children: controller.featuredCategories.map((category) => UCategoryTab()).toList()
          ),
        ),
      ),
    );
  }
}
