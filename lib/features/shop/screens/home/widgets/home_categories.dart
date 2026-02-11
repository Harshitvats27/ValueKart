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

class UHomeCategories extends StatelessWidget {
  const UHomeCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: USizes.spaceBtwSections),
      child: UVerticalImageText(
        textcolor: UColors.white,
        onTap: () => Get.to(() => SubCategoryScreen()),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../../../common/widgets/image_text/vertical_image_text.dart';
// import '../../../../../utils/constants/colors.dart';
// import '../../../../../utils/constants/sizes.dart';
// import '../../../controllers/categories/category_controller.dart';
// import '../../sub_category/sub_Category.dart';
//
// class UHomeCategories extends StatelessWidget {
//   const UHomeCategories({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     // Initialize controller
//     final controller = Get.put(CategoryController());
//
//     return Padding(
//       padding: const EdgeInsets.only(left: USizes.spaceBtwSections),
//       child: UVerticalImageText(
//         textcolor: UColors.white,
//         onTap: () {
//           // Navigate to SubCategoryScreen when any category is tapped
//           Get.to(() => SubCategoryScreen());
//         },
//       ),
//     );
//   }
// }
