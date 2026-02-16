import 'package:e_commerce_application/common/style/padding.dart';
import 'package:e_commerce_application/common/widgets/appbar/appbar.dart';
import 'package:e_commerce_application/common/widgets/custom_shape/rounded_container.dart';
import 'package:e_commerce_application/common/widgets/images/rounded_image.dart';
import 'package:e_commerce_application/common/widgets/shimmer/horizontal_product_shimmer.dart';
import 'package:e_commerce_application/common/widgets/text/section_heading.dart';
import 'package:e_commerce_application/features/shop/models/category_model.dart';
import 'package:e_commerce_application/features/shop/screens/all_products/all_products.dart';
import 'package:e_commerce_application/utils/constants/colors.dart';
import 'package:e_commerce_application/utils/constants/images.dart';
import 'package:e_commerce_application/utils/constants/sizes.dart';
import 'package:e_commerce_application/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/icons/circular_icon.dart';
import '../../../../common/widgets/products/product_cards/product_card_horizontal.dart';
import '../../../../utils/helpers/helper_function.dart';
import '../../controllers/categories/category_controller.dart';
import '../../models/product_model.dart';

class SubCategoryScreen extends StatelessWidget {
  const SubCategoryScreen({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final dark = UHelperfunctions.isDarkTheme(context);
    final controller = CategoryController.instance;
    return Scaffold(
      appBar: UAppBar(
        showBackArrow: true,
        title: Text(
          category.name,
          style: Theme
              .of(context)
              .textTheme
              .headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: UPadding.screenPadding,
          child: Column(
            children: [

              // fetch sub category
              FutureBuilder(
                future: controller.getSubCategories(category.id),

                builder: (context, snapshot) {
                  const loader =UHorizontalProductShimmer();
                  // Handle, loader, error, empty
                  final widget = UCloudHelperFunctions.checkMultiRecordState(
                      snapshot: snapshot);
                  if (widget != null) return widget;

                  // Data Found
                  List<CategoryModel> subCategories = snapshot.data!;

                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: subCategories.length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        CategoryModel subCategory = subCategories[index];
                        // fetch products for sub category
                        FutureBuilder(
                            future: controller.getCategoryProducts(
                                categoryId: subCategory.id),
                            builder: (context, snapshot) {
                              // handle error
                              const loader = UHorizontalProductShimmer();
                              final widget = UCloudHelperFunctions
                                  .checkMultiRecordState(snapshot: snapshot);
                              if (widget != null) return widget;
                              // data found
                              List<ProductModel> products = snapshot.data!;
                              return Column(
                                children: [
                                USectionHeading(title: subCategory.name,
                                onPressed: () =>
                                    Get.to(() =>
                                        AllProductsScreen(
                                            title: subCategory.name,
                                            futureMethod: controller
                                                .getCategoryProducts(
                                              categoryId: subCategory.id,
                                            limit: -1,
                                            ),
                                        )
                                    )
                                ),
                                SizedBox(height: USizes.spaceBtwItems / 2),
                                // Horizontal Product Card
                                SizedBox(
                                  height: 120,
                                  child: ListView.separated(
                                    separatorBuilder: (context, index) =>
                                        SizedBox(width: USizes.spaceBtwItems),
                                    itemCount: products.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      ProductModel product = products[index];
                                      return UProductCardHorizontal(
                                        productId: product,);
                                    },
                                  ),
                                ),
                                ],
                              );
                            }
                        );
                      });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
