import 'package:e_commerce_application/features/shop/controllers/controller/variation_controller.dart';
import 'package:e_commerce_application/utils/helpers/network_manager.dart';
import 'package:get/instance_manager.dart';

import '../features/personalisation/controllers/address_controller.dart';
import '../features/shop/controllers/cart/cart_controller.dart';
import '../features/shop/controllers/checkout/checkout_controller.dart';

class UBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(NetworkManager());
    Get.put(VariationController());
    Get.put(CartController());
    Get.put(CheckoutController());
    Get.put(AddressController());

  }

}