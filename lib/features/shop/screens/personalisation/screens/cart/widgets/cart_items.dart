import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../../../common/widgets/products/cart/cart_item.dart';
import '../../../../../../../common/widgets/products/cart/product_quantity_addnremove.dart';
import '../../../../../../../common/widgets/text/product_price_text.dart';
import '../../../../../../../utils/constants/sizes.dart';
import '../../../../../controllers/cart/cart_controller.dart';

class UCartItems extends StatelessWidget {
  const UCartItems({super.key, this.showAddRemoveButtons = true});

  final bool showAddRemoveButtons;

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    return Obx(
      ()=> ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) =>
            SizedBox(height: USizes.spaceBtwSections),
        itemCount: controller.cartItems.length,
        itemBuilder: (context, index) {
           final cartItem = controller.cartItems[index];
          return Column(
            children: [
              UCartItem(cartItem: cartItem),
              if (showAddRemoveButtons) SizedBox(height: USizes.spaceBtwItems),
              if (showAddRemoveButtons)
                Row(
                  children: [
                    SizedBox(width: 70),
                    // price and counter
                    UProductQuantityandRemove(
                      quantity: cartItem.quantity,
                      add: () => controller.addOneToCart(cartItem),
                      remove: ()=>controller.removeOneFromCart(cartItem),
                    ),
                    Spacer(),
                    UProductPriceText(price:(cartItem.price*cartItem.quantity).toStringAsFixed(0)),
                  ],
                ),
            ],
          );
        },
      ),
    );
  }
}
