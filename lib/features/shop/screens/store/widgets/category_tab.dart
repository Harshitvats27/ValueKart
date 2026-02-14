import 'package:e_commerce_application/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:e_commerce_application/features/shop/models/category_model.dart';
import 'package:e_commerce_application/features/shop/screens/all_products/all_products.dart';
import 'package:e_commerce_application/features/shop/screens/store/widgets/category_brands.dart';
import 'package:e_commerce_application/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../common/layout/grid_layout.dart';
import '../../../../../common/widgets/brands/brand_showcase.dart';
import '../../../../../common/widgets/products/product_cards/product_cards_vertical.dart';
import '../../../../../common/widgets/text/section_heading.dart';
import '../../../../../utils/constants/images.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/categories/category_controller.dart';
import '../../../models/product_model.dart';

class UCategoryTab extends StatelessWidget {
  const UCategoryTab({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: USizes.defaultSpace),
          child: Column(
            children: [
              CategoryBrands(category: category),

              SizedBox(height: USizes.spaceBtwItems),
              USectionHeading(
                title: 'You  Might Like ',
                onPressed: () => Get.to(
                  () => AllProductsScreen(
                    title: category.name,
                    futureMethod: controller.getCategoryProducts(
                      categoryId: category.id,
                      limit: -1,
                    ),
                  ),
                ),
              ),
              FutureBuilder(
                future: controller.getCategoryProducts(categoryId: category.id),

                builder: (context, snapshot) {
                  ;
                  // Handle loader error and empty states
                  const loader = UVerticalProductShimmer(itemCount: 4,);
                  final widget = UCloudHelperFunctions.checkMultiRecordState(
                    snapshot: snapshot,
                    loader: loader,
                  );
                  if (widget != null) {
                    return widget;
                  }

                  // products found
                  List<ProductModel>products = snapshot.data!;
                  return UGridLayout(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      ProductModel product =products[index];
                      return UProductcardVertical(
                        productModel: product,
                      );
                    },
                  );
                },
              ),
              SizedBox(height: USizes.spaceBtwSections),
            ],
          ),
        ),
      ],
    );
  }
}
