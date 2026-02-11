import 'package:e_commerce_application/utils/helpers/network_manager.dart';
import 'package:get/instance_manager.dart';

class UBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(NetworkManager());
  }

}