import 'package:e_commerce_application/features/shop/models/category_model.dart';
import 'package:e_commerce_application/features/shop/screens/store/widgets/category_brands.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../common/layout/grid_layout.dart';
import '../../../../../common/widgets/brands/brand_showcase.dart';
import '../../../../../common/widgets/products/product_cards/product_cards_vertical.dart';
import '../../../../../common/widgets/text/section_heading.dart';
import '../../../../../utils/constants/images.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../models/product_model.dart';

class UCategoryTab extends StatelessWidget {
  const UCategoryTab({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: USizes.defaultSpace),
          child: Column(
            children: [
              CategoryBrands(),

              SizedBox(height: USizes.spaceBtwItems),
              USectionHeading(title: 'You  Might Like ', onPressed: () {}),
              UGridLayout(
                itemCount: 45,
                itemBuilder: (context, index) {
                  return UProductcardVertical(
                    productModel: ProductModel.empty(),
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
