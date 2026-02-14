import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_application/common/widgets/shimmer/shimmer_effect.dart';
import 'package:e_commerce_application/features/shop/models/brand_model.dart';
import 'package:e_commerce_application/features/shop/screens/brands/brand_products.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/images.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_function.dart';
import '../custom_shape/rounded_container.dart';
import 'brand_cards.dart';

class UBrandShowcase extends StatelessWidget {
  const UBrandShowcase({super.key, required this.images, required this.brand});

  final List<String> images;
  final BrandModel brand;


  @override
  Widget build(BuildContext context) {
    final dark = UHelperfunctions.isDarkTheme(context);
    return InkWell(
      onTap: ()=>Get.to(()=>BrandProductsScreen(title: brand.name, brand: brand)),
      child: URoundedContainer(
        showBorder: true,
        borderColor: UColors.darkerGrey,
        backgroundColor: Colors.transparent,
        padding: const EdgeInsets.all(USizes.md),
        margin: const EdgeInsets.only(bottom: USizes.spaceBtwItems),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UBrandCard(showBorder: false, brand: brand,),
            Row(
              children: images
                  .map((image) => buildBrandImage(dark, image))
                  .toList(),
            ),
          ],
        ),
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
        child: CachedNetworkImage(imageUrl: image,fit: BoxFit.contain,progressIndicatorBuilder:(context,url,progress)=>UShimmerEffect(width: 100, height: 100) ,
        errorWidget: (context ,url,error)=>Icon(Icons.error),
        )
      ),
    );
  }
}
