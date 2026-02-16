import 'package:e_commerce_application/common/widgets/shimmer/category_shimmer.dart';
import 'package:e_commerce_application/features/shop/models/category_model.dart';
import 'package:e_commerce_application/utils/constants/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../common/widgets/custom_shape/circular_contaner.dart';
import '../../../../../common/widgets/image_text/vertical_image_text.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text.dart';
import '../../sub_category/sub_Category.dart';
//
// class UHomeCategories extends StatelessWidget {
//   const UHomeCategories({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(left: USizes.spaceBtwSections),
//       child: UVerticalImageText(
//         textcolor: UColors.white,
//         onTap: () => Get.to(() => SubCategoryScreen()),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/widgets/image_text/vertical_image_text.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/categories/category_controller.dart';
import '../../sub_category/sub_Category.dart';
class UHomeCategories extends StatelessWidget {
  const UHomeCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryController());

    return Padding(
      padding: const EdgeInsets.only(
        left: USizes.spaceBtwSections,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// Section Heading
          Text(
            UTexts.popularCategories,
            style: Theme
                .of(context)
                .textTheme
                .headlineSmall!
                .apply(color: UColors.white),
          ),

          const SizedBox(height: USizes.spaceBtwItems),

          /// Categories ListView
          Obx(() {
            final categories = controller.featuredCategories;

            /// 🔄 Loading State
            if (controller.isLoading.value) {
              return const UCategoryShimmer(itemCount: 6);
            }

            /// ❌ Empty State
            if (categories.isEmpty) {
              return const Text('Categories Not Found');
            }

            /// ✅ Data Found
            return SizedBox(
              height: 82,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                separatorBuilder: (context, index) =>
                const SizedBox(width: USizes.spaceBtwItems),
                itemBuilder: (context, index) {
                  CategoryModel category = categories[index];

                  return UVerticalImageText(
                    title: category.name,
                    image: category.image,
                    textColor: UColors.white,
                    onTap: () {
                      // Navigate to SubCategory Screen
                      Get.to(() => SubCategoryScreen(category: category,));
                    },
                  );
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}