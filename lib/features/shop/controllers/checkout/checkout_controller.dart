import 'package:e_commerce_application/common/widgets/custom_shape/rounded_container.dart';
import 'package:e_commerce_application/features/shop/models/payment_mehod_model.dart';
import 'package:e_commerce_application/utils/constants/images.dart';
import 'package:e_commerce_application/utils/constants/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/text/section_heading.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/helpers/helper_function.dart';
import '../../screens/personalisation/screens/checkout/widgets/payment_tile.dart';

class CheckoutController extends GetxController {
  static CheckoutController get instance => Get.find();

  // Variables
  Rx<PaymentMethodModel> selectedPaymentMethod = PaymentMethodModel.empty().obs;


  @override
  void onInit() {
    super.onInit();
  selectedPaymentMethod.value=PaymentMethodModel(name: 'Cash on Delivery', image: UImages.codIcon, paymentMethod: PaymentMethods.creditCard);
  } // Methods

  Future<void> selectPaymentMethod(BuildContext context) {
    return showModalBottomSheet(context: context ,builder: (context)=>SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(USizes.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            USectionHeading(title: 'Select Payment Method',showActionButtton:false),
            SizedBox(height: USizes.spaceBtwSections,),
            UPaymentTile(paymentMethod: PaymentMethodModel(name: 'Cash on Delivery', image: UImages.codIcon, paymentMethod: PaymentMethods.creditCard),),
            SizedBox(height: USizes.spaceBtwItems/2,),
            UPaymentTile(paymentMethod: PaymentMethodModel(name: 'Paypal', image: UImages.paypal, paymentMethod: PaymentMethods.creditCard),),
            SizedBox(height: USizes.spaceBtwItems/2,),
            UPaymentTile(paymentMethod: PaymentMethodModel(name: 'Credit Card', image: UImages.creditCard, paymentMethod: PaymentMethods.creditCard),),
            SizedBox(height: USizes.spaceBtwItems/2,),
            UPaymentTile(paymentMethod: PaymentMethodModel(name: 'Master Card', image: UImages.masterCard, paymentMethod: PaymentMethods.creditCard),),
            SizedBox(height: USizes.spaceBtwSections,),





          ],
        ),
      ),
    ));
  }
}
