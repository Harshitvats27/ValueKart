import 'package:e_commerce_application/common/widgets/shimmer/shimmer_effect.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../features/shop/controllers/categories/category_controller.dart';
import '../../../features/shop/models/category_model.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/constants/text.dart';
import '../../../utils/helpers/helper_function.dart';
import '../custom_shape/circular_contaner.dart';

// class UVerticalImageText extends StatelessWidget {
//   const UVerticalImageText({
//     super.key,
//     required this.title,
//     required this.image,
//     required this.textcolor,
//     this.backgroundColor,
//     this.onTap,
//   });
//
//   final String title, image;
//   final Color textcolor;
//   final Color? backgroundColor;
//   final VoidCallback? onTap;
//
//   @override
//   Widget build(BuildContext context) {
//     bool dark = UHelperfunctions.isDarkTheme(context);
//     return GestureDetector(
//       onTap: onTap,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             UTexts.popularCategories,
//             style: Theme.of(
//               context,
//             ).textTheme.headlineSmall!.apply(color: UColors.white),
//           ),
//           SizedBox(height: USizes.spaceBtwItems),
//
//           // Categories
//           SizedBox(
//             height: 80,
//             child: ListView.separated(
//               separatorBuilder: (context, index) =>
//                   SizedBox(width: USizes.spaceBtwItems),
//               itemCount: 10,
//               scrollDirection: Axis.horizontal,
//               itemBuilder: (context, index) {
//                 return Column(
//                   children: [
//                     UCircularContaimer.UCircularContainer(
//                       height: 56,
//                       width: 56,
//                       padding: EdgeInsets.all(8),
//                       backgroundColor:
//                           backgroundColor ??
//                           (dark ? UColors.dark : UColors.light),
//                       child: Image(image: AssetImage(image), fit: BoxFit.cover),
//                     ),
//                     SizedBox(height: USizes.spaceBtwItems / 2),
//                     SizedBox(
//                       width: 55,
//                       child: Text(
//                         title,
//                         style: Theme.of(
//                           context,
//                         ).textTheme.labelMedium!.apply(color: textcolor),
//                         overflow: TextOverflow.ellipsis,
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                   ],
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:e_commerce_application/common/widgets/shimmer/shimmer_effect.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../features/shop/controllers/categories/category_controller.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/constants/text.dart';
import '../../../utils/helpers/helper_function.dart';
import '../custom_shape/circular_contaner.dart';
import '../shimmer/category_shimmer.dart';

class UVerticalImageText extends StatelessWidget {
  const UVerticalImageText({
    super.key,
    required this.textcolor,
    this.backgroundColor,
    this.onTap,
  });

  final Color textcolor;
  final Color? backgroundColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    final dark = UHelperfunctions.isDarkTheme(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Heading
        Text(
          UTexts.popularCategories,
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .apply(color: UColors.white),
        ),
        const SizedBox(height: USizes.spaceBtwItems),

        /// Categories List
        SizedBox(
          height: 80,
          child: Obx(() {
            /// LOADING
            if (controller.isLoading.value) {
              return ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 6,
                separatorBuilder: (_, __) =>
                const SizedBox(width: USizes.spaceBtwItems),
                itemBuilder: (_, __) => UCategoryShimmer(),
              );
            }

            /// EMPTY STATE
            if (controller.featuredCategories.isEmpty) {
              return const Center(child: Text('No Categories'));
            }

            /// DATA
            return ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: controller.featuredCategories.length,
              separatorBuilder: (_, __) =>
              const SizedBox(width: USizes.spaceBtwItems),
              itemBuilder: (_, index) {
                final category = controller.featuredCategories[index];

                return GestureDetector(
                  onTap: onTap,
                  child: Column(
                    children: [
                      /// Image
                      UCircularContaimer.UCircularContainer(
                        height: 56,
                        width: 56,
                        padding: const EdgeInsets.all(8),
                        backgroundColor: backgroundColor ??
                            (dark ? UColors.dark : UColors.light),
                        child: ClipOval(
                          child: category.image.isEmpty
                              ? const Icon(Icons.image)
                              : Image.network(
                            category.image,
                            fit: BoxFit.cover,
                            width: 56,
                            height: 56,
                            errorBuilder: (_, __, ___) =>
                            const Icon(Icons.broken_image),
                          ),
                        ),

                      ),

                      const SizedBox(height: 6),

                      /// Name
                      SizedBox(
                        width: 55,
                        child: Text(
                          category.name,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .apply(color: textcolor),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }),
        ),
      ],
    );
  }

  /// ✅ Proper shimmer using YOUR component
  Widget _categoryShimmer() {
    return Column(
      children: const [
        UShimmerEffect(
          width: 56,
          height: 56,
          radius: 100,
        ),
        SizedBox(height: 6),
        UShimmerEffect(
          width: 40,
          height: 10,
          radius: 8,
        ),
      ],
    );
  }
}
