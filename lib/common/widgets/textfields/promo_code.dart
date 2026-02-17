import 'package:e_commerce_application/features/shop/controllers/promo_code/promo_code_controller.dart';
import 'package:e_commerce_application/utils/helpers/helper_function.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../custom_shape/rounded_container.dart';

class UPromoCodeField extends StatelessWidget {
  const UPromoCodeField({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = UHelperfunctions.isDarkTheme(context);
    final controller = PromoCodeController.instance;
    return URoundedContainer(
      showBorder: true,
      backgroundColor: Colors.transparent,
      padding: EdgeInsets.only(
        bottom: USizes.sm,
        left: USizes.sm,
        right: USizes.sm,
        top: USizes.sm,
      ),
      child: Row(
        children: [
          Flexible(
            child: TextFormField(
              onChanged: controller.onPromoChanged,
              decoration: InputDecoration(
                hintText: 'Have a PromoCode? Enter Here',
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
          ),
          SizedBox(
            width: 80,
            child: Obx(
              () => ElevatedButton(
                onPressed: controller.appliedPromoCode.value.id.isNotEmpty
                    ? null
                    : controller.promoCode.isEmpty
                    ? null
                    : controller.applyPromoCode,
                style: ElevatedButton.styleFrom(
                  side: BorderSide(color: Colors.grey.withValues(alpha: 0.1)),
                ),
                child: controller.isLoading.value
                    ? SizedBox(
                        width: USizes.lg,
                        height: USizes.lg,
                        child: CircularProgressIndicator(color: UColors.white),
                      )
                    : Text(controller.appliedPromoCode.value.id.isEmpty?'Apply':'Applied'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
