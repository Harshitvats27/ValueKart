import 'package:e_commerce_application/features/shop/models/brand_model.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/images.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_function.dart';
import '../custom_shape/rounded_container.dart';
import 'brand_cards.dart';

class UBrandShowcase extends StatelessWidget {
  const UBrandShowcase({super.key, required this.images});

  final List<String> images;

  @override
  Widget build(BuildContext context) {
    final dark = UHelperfunctions.isDarkTheme(context);
    return URoundedContainer(
      showBorder: true,
      borderColor: UColors.darkerGrey,
      backgroundColor: Colors.transparent,
      padding: const EdgeInsets.all(USizes.md),
      margin: const EdgeInsets.only(bottom: USizes.spaceBtwItems),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UBrandCard(showBorder: false, brand: BrandModel.empty(),),
          Row(
            children: images
                .map((image) => buildBrandImage(dark, image))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget buildBrandImage(bool dark, String image) {
    return Expanded(
      child: URoundedContainer(
        height: 100,
        margin: const EdgeInsets.only(right: USizes.sm),
        showBorder: true,
        borderColor: UColors.darkerGrey,
        backgroundColor: dark ? UColors.darkerGrey : UColors.light,
        child: Image(image: AssetImage(image), fit: BoxFit.contain),
      ),
    );
  }
}
