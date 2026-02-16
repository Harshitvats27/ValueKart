import 'package:e_commerce_application/common/style/padding.dart';
import 'package:e_commerce_application/common/widgets/appbar/appbar.dart';
import 'package:e_commerce_application/common/widgets/custom_shape/rounded_container.dart';
import 'package:e_commerce_application/common/widgets/screeens/success_screen.dart';
import 'package:e_commerce_application/features/shop/screens/personalisation/screens/cart/widgets/cart_items.dart';
import 'package:e_commerce_application/features/shop/screens/personalisation/screens/checkout/widgets/billing_address_section.dart';
import 'package:e_commerce_application/features/shop/screens/personalisation/screens/checkout/widgets/billing_amount_section.dart';
import 'package:e_commerce_application/features/shop/screens/personalisation/screens/checkout/widgets/billing_payment_section.dart';
import 'package:e_commerce_application/navigation_menu.dart';
import 'package:e_commerce_application/utils/constants/colors.dart';
import 'package:e_commerce_application/utils/constants/images.dart';
import 'package:e_commerce_application/utils/constants/sizes.dart';
import 'package:e_commerce_application/utils/constants/text.dart';
import 'package:e_commerce_application/utils/helpers/helper_function.dart';
import 'package:e_commerce_application/utils/helpers/pricing_calculator.dart';
import 'package:e_commerce_application/utils/pop_ups/snackbar_helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../../common/widgets/button/elevated_button.dart';
import '../../../../../../common/widgets/textfields/promo_code.dart';
import '../../../../controllers/cart/cart_controller.dart';
import '../../../../controllers/order/order_controller.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = UHelperfunctions.isDarkTheme(context);
    final controller = CartController.instance;
    final orderController = Get.put(OrderController());
    double subTotal = controller.totalCartPrice.value;
    double totalPrice = UPricingCalculator.calculateTotalPrice(
      subTotal,
      'Kenya',
    );
    return Scaffold(
      appBar: UAppBar(
        showBackArrow: true,
        title: Text(
          'Order Review',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      // body
      body: SingleChildScrollView(
        child: Padding(
          padding: UPadding.screenPadding,
          child: Column(
            children: [
              UCartItems(showAddRemoveButtons: false),
              SizedBox(height: USizes.spaceBtwSections),
              UPromoCodeField(),
              SizedBox(height: USizes.spaceBtwSections),

              URoundedContainer(
                showBorder: true,
                padding: EdgeInsets.all(USizes.md),
                backgroundColor: Colors.transparent,
                child: Column(
                  children: [
                    UBillingAmountSection(),
                    SizedBox(height: USizes.spaceBtwItems),
                    UBillingPaymentSection(),
                    SizedBox(height: USizes.spaceBtwItems),
                    UBillingAddressSection(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: UElevatedButton(
        onPressed: subTotal > 0
            ?()=> orderController.processOrder(totalPrice)
            : ()=>USnackBarHelpers.errorSnackBar(
                title: 'Empty Cart',
                message: 'Add items in the cart',
              ),
        child: Text('Checkout ${UTexts.currency}$totalPrice'),
      ),
    );
  }
}
