import 'package:e_commerce_application/utils/constants/text.dart';
import 'package:e_commerce_application/utils/helpers/pricing_calculator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../../../utils/constants/colors.dart';
import '../../../../../../../utils/constants/sizes.dart';
import '../../../../../controllers/cart/cart_controller.dart';
import '../../../../../controllers/promo_code/promo_code_controller.dart';

class UBillingAmountSection extends StatelessWidget {
  const UBillingAmountSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    final subTotal = cartController.totalCartPrice.value;
    final promoCodeController =PromoCodeController.instance;


    return Column(
      children: [
        Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'SubTotal',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                Text(
                  '${UTexts.currency}$subTotal',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            SizedBox(height: USizes.spaceBtwItems / 2),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Shipping Fee',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                Text(
                  '${UTexts.currency}${UPricingCalculator.calculateShippingCost(subTotal, 'Kenya')}',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ],
            ),
            SizedBox(height: USizes.spaceBtwItems / 2),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Tax Fee',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                Text(
                  '${UTexts.currency}${UPricingCalculator.calculateTax(subTotal, 'Kenya')}',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ],
            ),
            SizedBox(height: USizes.spaceBtwItems / 2),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Order Total',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                Obx(
                  (){
                    double totalPrice = UPricingCalculator.calculateTotalPrice(
                      subTotal,
                      'Kenya',
                    );
                    final promoCode = promoCodeController.appliedPromoCode.value;
                     totalPrice = promoCodeController.calculatePriceAfterDiscount(
                      promoCode,
                      totalPrice,
                    );

                    return Text(
                      '${UTexts.currency}${totalPrice.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.titleMedium,
                    );
                  }
                ),
              ],
            ),

SizedBox(height: USizes.spaceBtwItems / 2),
            Obx(() {
              final promoCode = promoCodeController.appliedPromoCode.value;

              if (promoCode.id.isEmpty) return SizedBox();

              return Row(
                children: [
                  Expanded(
                    child: Text(
                      'Discount',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .apply(color: UColors.success),
                    ),
                  ),
                  Text(promoCodeController.getDiscountPrice()),
                ],
              );
            })








          ],
        ),
      ],
    );
  }
}
