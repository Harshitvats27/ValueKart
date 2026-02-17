import 'package:e_commerce_application/features/shop/controllers/brand/brand_controller.dart';
import 'package:e_commerce_application/features/shop/screens/brands/all_brands.dart';
import 'package:e_commerce_application/features/shop/screens/brands/brand_products.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../common/widgets/image_text/vertical_image_text.dart';
import '../../../../../common/widgets/text/section_heading.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/images.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_function.dart';
import '../../../models/brand_model.dart';

class SearchStoreBrands extends StatelessWidget {
  const SearchStoreBrands({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BrandController());
    final bool dark = UHelperfunctions.isDarkTheme(context);
    return Obx(() {
      // state loading
      if (controller.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      }
      // state empty
      if (controller.allBrands.isEmpty) {
        return Center(child: Text('No Brands Found'));
      }
      // state data found
      List<BrandModel> brands = controller.allBrands.take(10).toList();
      return Column(
        children: [
          USectionHeading(title: 'Brands',onPressed: ()=>Get.to(()=>AllBrandsScreen()),),
          SizedBox(height: USizes.spaceBtwItems),
          Wrap(
            spacing: USizes.spaceBtwItems,
            runSpacing: USizes.spaceBtwItems,
            children: brands
                .map(
                  (brand) => UVerticalImageText(
                    onTap: ()=>Get.to(()=>BrandProductsScreen(title: brand.name, brand: brand)),
                    title: brand.name,
                    image: brand.image,
                    textColor: dark ? UColors.light : UColors.black,
                  ),
                )
                .toList(),
          ),
        ],
      );
    });
  }
}
