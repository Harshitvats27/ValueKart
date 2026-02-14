import 'package:e_commerce_application/common/widgets/brands/brand_showcase.dart';
import 'package:e_commerce_application/common/widgets/shimmer/boxes_shimmer.dart';
import 'package:e_commerce_application/common/widgets/shimmer/list_tile_shimmer.dart';
import 'package:e_commerce_application/features/shop/models/category_model.dart';
import 'package:e_commerce_application/utils/constants/images.dart';
import 'package:e_commerce_application/utils/constants/sizes.dart';
import 'package:e_commerce_application/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/cupertino.dart';

import '../../../controllers/brand/brand_controller.dart';
import '../../../models/brand_model.dart';

class CategoryBrands extends StatelessWidget {
  const CategoryBrands({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return FutureBuilder(
      future: controller.getBrandsForCategory(category.id),
      builder: (context, snapshot) {
        const loader = Column(
          children: [
            UListTileShimmer(),
            SizedBox(height: USizes.spaceBtwItems),
            UBoxesShimmer(),
            SizedBox(height: USizes.spaceBtwItems),
          ],
        );

        final Widget = UCloudHelperFunctions.checkMultiRecordState(
          snapshot: snapshot,
          loader: loader,
        );
        if (Widget != null) {
          return Widget;
        }

        // brands found
        final brands = snapshot.data!;
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: brands.length,
          itemBuilder: (context, index) {
            final brand = brands[index];
            return FutureBuilder(
              future: controller.getBrandProducts(brand.id, limit: 3),
              builder: (context, snapshot) {
                // Handle loader no records found
                final widget = UCloudHelperFunctions.checkMultiRecordState(
                  snapshot: snapshot,
                  loader: loader,
                );
                if (widget != null) {
                  return widget;
                }

                // products found
                final products = snapshot.data!;

                return UBrandShowcase(
                  images: products.map((product) => product.thumbnail).toList(),

                  brand: brand,
                );
              },
            );
          },
        );
      },
    );
  }
}
