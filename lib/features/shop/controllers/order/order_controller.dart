import 'package:e_commerce_application/common/data/repositories/authentication_repository.dart';
import 'package:e_commerce_application/features/shop/controllers/cart/cart_controller.dart';
import 'package:e_commerce_application/utils/pop_ups/snackbar_helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/screeens/success_screen.dart';
import '../../../../data/repositories/order/order_repository.dart';
import '../../../../navigation_menu.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/constants/images.dart';
import '../../../../utils/pop_ups/full_screen_loader.dart';
import '../../../personalisation/controllers/address_controller.dart';
import '../../models/order_model.dart';
import '../checkout/checkout_controller.dart';

class OrderController extends GetxController{
  static OrderController get instance => Get.find();
  final cartController =CartController.instance;
  final checkoutControllerc =CheckoutController.instance;
  final addressController =AddressController.instance;
  final _repository = Get.put(OrderRepository());


  Future<void> processOrder(double totalAmount) async {
    try {
      // start loading
      UFullScreenLoader.openLoadingDialog('Processing your order...');

      // check user existence
      String userId = AuthenticationReposiotory.instance.currentUser!.uid;
      if (userId.isEmpty) return;

      // Create Order Model
      OrderModel order = OrderModel(
        id: UniqueKey().toString(),
        status: OrderStatus.pending,
        items: cartController.cartItems.toList(),
        totalAmount: totalAmount,
        orderDate: DateTime.now(),
        userId: userId,
        paymentMethod: checkoutControllerc.selectedPaymentMethod.value.name,
        address: addressController.selectedAddress.value,
        deliveryDate: DateTime.now().add(Duration(days: 3)),
      );
      await _repository.saveOrder(order);
      cartController.clearCart();
      Get.to(
            () => SuccessScreen(
          image: UImages.successfulPaymentIcon,
          title: 'Payment Success',
          subTitle: 'Your Items will be Shipped Soon',
          onTap: () => Get.offAll(() => NavigationMenu())
        )
      );

    } catch (e) {
      USnackBarHelpers.errorSnackBar(title: 'Order Failed',message: e.toString());

    }
  }



  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final orders = await _repository.fetchUserOrders();
      return orders;
    } catch (e) {
      USnackBarHelpers.errorSnackBar(
        title: 'Failed',
        message: e.toString(),
      );
      return [];
    }
  }




}