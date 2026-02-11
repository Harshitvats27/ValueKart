import 'package:e_commerce_application/common/widgets/custom_shape/rounded_container.dart';
import 'package:e_commerce_application/common/widgets/text/product_price_text.dart';
import 'package:e_commerce_application/common/widgets/text/product_title_text.dart';
import 'package:e_commerce_application/common/widgets/text/section_heading.dart';
import 'package:e_commerce_application/features/shop/models/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../../common/widgets/chips/choice_chip.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text.dart';
import '../../../../../utils/helpers/helper_function.dart';
import '../../../controllers/controller/variation_controller.dart';

class UProductAttributes extends StatelessWidget {
  const UProductAttributes({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = UHelperfunctions.isDarkTheme(context);
    final controller = Get.put(VariationController());
    return Obx(
        ()=> Column(
        children: [
          // selected attributes prices and
          if(controller.selectedVariation.value.id.isNotEmpty)
          URoundedContainer(
            padding: EdgeInsets.all(USizes.sm),
            backgroundColor: dark ? UColors.darkGrey : UColors.grey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // title prices and stock
                Row(
                  children: [
                    // variation heading
                    USectionHeading(
                      showActionButtton: false,
                      title: 'Variations',
                    ),
                    SizedBox(width: USizes.spaceBtwItems),
                    Column(
                      children: [
                        Row(
                          children: [
                            UProductTitleText(title: 'Price', smallSize: true),
                            SizedBox(width: USizes.spaceBtwItems),
                            if(controller.selectedVariation.value.salePrice>0)
                            Text(
                              '${UTexts.currency}#${controller.selectedVariation.value.salePrice.toStringAsFixed(0)}',
                              style: Theme.of(context).textTheme.titleSmall!
                                  .apply(decoration: TextDecoration.lineThrough),
                            ),
                            SizedBox(width: USizes.spaceBtwItems),
                            UProductPriceText(price: controller.getVariationPrice()),
                          ],
                        ),
                        Row(
                          children: [
                            UProductTitleText(title: 'Stock', smallSize: true),
                            SizedBox(width: USizes.spaceBtwItems),
                            Text(
                              controller.variationStockStatus.value,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),

                // attribute descriptioon
                UProductTitleText(
                  title: controller.selectedVariation.value.description??'',
                  smallSize: true,
                  maxLines: 4,
                ),
                SizedBox(height: USizes.spaceBtwItems),
              ],
            ),
          ),
          SizedBox(height: USizes.spaceBtwItems),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: product.productAttributes!.map((attribute) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  USectionHeading(
                    title: attribute.name ?? '',
                    showActionButtton: false,
                  ),
                  SizedBox(height: USizes.spaceBtwItems / 2),

                  Wrap(
                    spacing: USizes.sm,

                    children: attribute.values!.map((attributeValues) {
                      bool isSelected =
                          controller.selectedAttribute[attribute.name] ==
                          attributeValues;
                      final availabe = controller
                          .getAttributesAvailabilityInVariation(
                            product.productVariations!,
                            attribute.name!,
                          )
                          .contains(attributeValues);

                      return UChoiceChip(
                        text: attributeValues,
                        selected: true,
                        onSelected: availabe
                            ? (selected) {
                                if (availabe && selected) {
                                  controller.onAttributeSelected(
                                    product,
                                    attribute.name,
                                    attributeValues,
                                  );
                                }
                              }
                            : null,
                      );
                    }).toList(),
                  ),
                ],
              );
            }).toList(),
          ),

          // Attributes - colors , size , brands
        ],
      ),
    );
  }
}
