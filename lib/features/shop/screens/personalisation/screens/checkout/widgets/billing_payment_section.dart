import 'package:e_commerce_application/common/widgets/custom_shape/rounded_container.dart';
import 'package:e_commerce_application/common/widgets/text/section_heading.dart';
import 'package:e_commerce_application/utils/constants/images.dart';
import 'package:e_commerce_application/utils/constants/sizes.dart';
import 'package:e_commerce_application/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../../../utils/constants/colors.dart';
import '../../../../../controllers/cart/cart_controller.dart';
import '../../../../../controllers/checkout/checkout_controller.dart';

class UBillingPaymentSection extends StatelessWidget {
  const UBillingPaymentSection({super.key});


  @override
  Widget build(BuildContext context) {
    final dark =UHelperfunctions.isDarkTheme(context);
    final controller = Get.put(CheckoutController());
    return Column(
      children: [
        USectionHeading(title: 'Payment Method',buttonTitle: 'Change',onPressed: ()=>controller.selectPaymentMethod(context)),
        SizedBox(height: USizes.spaceBtwItems/2,),
        Obx(
          ()=> Row(
            children: [
              URoundedContainer(
                width: 60,
                height: 35,
                backgroundColor: dark? UColors.light:UColors.white,
                padding: EdgeInsets.all(USizes.sm),
                child: Image(
                  image: AssetImage(controller.selectedPaymentMethod.value.image,),fit: BoxFit.contain,
                ),
              ),
              SizedBox(width:USizes.spaceBtwItems/2 ,),

              Text(controller.selectedPaymentMethod.value.name,style: Theme.of(context).textTheme.bodyLarge,)
            ],
          ),
        )
      ],
    );
  }
}
