
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../../common/widgets/custom_shape/rounded_container.dart';
import '../../../../../../../utils/constants/colors.dart';
import '../../../../../../../utils/constants/sizes.dart';
import '../../../../../../../utils/helpers/helper_function.dart';
import '../../../../../controllers/checkout/checkout_controller.dart';
import '../../../../../models/payment_mehod_model.dart';

class UPaymentTile extends StatelessWidget {
  const UPaymentTile({super.key, required this.paymentMethod});

  final PaymentMethodModel paymentMethod;


  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CheckoutController());
    return ListTile(
      onTap: (){
        controller.selectedPaymentMethod.value = paymentMethod;
        Get.back();
      },
      contentPadding: EdgeInsets.zero,
      leading: URoundedContainer(
        width: 60,
        height: 40,
        backgroundColor: UHelperfunctions.isDarkTheme(context)?UColors.light:UColors.white,
        padding: EdgeInsets.all(USizes.sm),
        child: Image(image: AssetImage(paymentMethod.image),fit: BoxFit.contain,),
      ),
      title: Text( paymentMethod.name,style: Theme.of(context).textTheme.bodyLarge,),
      trailing: Icon(Iconsax.arrow_right_34),
    );
  }
}
