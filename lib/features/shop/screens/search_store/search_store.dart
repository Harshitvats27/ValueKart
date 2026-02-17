import 'package:e_commerce_application/common/layout/grid_layout.dart';
import 'package:e_commerce_application/common/style/padding.dart';
import 'package:e_commerce_application/common/widgets/appbar/appbar.dart';
import 'package:e_commerce_application/common/widgets/custom_shape/rounded_container.dart';
import 'package:e_commerce_application/common/widgets/image_text/vertical_image_text.dart';
import 'package:e_commerce_application/common/widgets/images/rounded_image.dart';
import 'package:e_commerce_application/common/widgets/products/product_cards/product_cards_vertical.dart';
import 'package:e_commerce_application/common/widgets/text/section_heading.dart';
import 'package:e_commerce_application/features/shop/controllers/categories/category_controller.dart';
import 'package:e_commerce_application/features/shop/controllers/controller/product_controller.dart';
import 'package:e_commerce_application/features/shop/screens/search_store/widgets/search_store_brands.dart';
import 'package:e_commerce_application/features/shop/screens/search_store/widgets/search_store_categories.dart';
import 'package:e_commerce_application/utils/constants/colors.dart';
import 'package:e_commerce_application/utils/constants/sizes.dart';
import 'package:e_commerce_application/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/images.dart';

class SearchStoreScreen extends StatelessWidget {
  const SearchStoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    RxString searchText = ''.obs;
    return Scaffold(
      appBar: UAppBar(
        showBackArrow: true,
        title: Text(
          'Search',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        padding: UPadding.screenPadding,
        child: Column(
          children: [
            Hero(
              tag: 'search_animation',
              child: Material(
                color: Colors.transparent,
                child: TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Iconsax.search_normal),
                    hintText: 'Search in Store',
                  ),
                  onChanged: (value) => searchText.value = value,
                ),
              ),
            ),
            SizedBox(height: USizes.spaceBtwItems),
            // Brands
            Obx(() {
              if (searchText.value.isEmpty) {
                return Column(
                  children: [
                    SearchStoreBrands(),
                    SizedBox(height: USizes.spaceBtwSections),
                    // Categories
                    SearchStoreCategories(),
                  ],
                );
              }
              return FutureBuilder(
                future: ProductController.instance.getAllProducts(),
                builder: (context, snapshot) {
                  // Handle loading error empty
                  final widget = UCloudHelperFunctions.checkMultiRecordState(
                    snapshot: snapshot,
                  );
                  if (widget != null) return widget;
                  final products = snapshot.data!;
                  // Filter products based on search text
                  final filteredProducts = products
                      .where(
                        (product) => product.title.toLowerCase().contains(
                          searchText.value.toLowerCase(),
                        ),
                      )
                      .toList();
                  return UGridLayout(
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];
                      return UProductcardVertical(productModel: product);
                    },
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
