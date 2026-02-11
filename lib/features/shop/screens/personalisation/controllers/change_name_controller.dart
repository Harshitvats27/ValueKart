import 'package:e_commerce_application/features/personalisation/controllers/user_controller.dart';
import 'package:e_commerce_application/navigation_menu.dart';
import 'package:e_commerce_application/utils/helpers/network_manager.dart';
import 'package:e_commerce_application/utils/pop_ups/full_screen_loader.dart';
import 'package:e_commerce_application/utils/pop_ups/snackbar_helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../../common/data/repositories/user/user_repository.dart';

class ChangeNameController extends GetxController {
  static ChangeNameController get instance => Get.find();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final _userController = UserController.instance;
  final updateUserFormKey = GlobalKey<FormState>();
  final _userRepository = UserRepository.instance;


  @override
  void onInit() {
    initializeNames();
    super.onInit();
  }

  void initializeNames() {
    firstName.text = _userController.user.value.firstName;
    lastName.text = _userController.user.value.lastName;
  }

  Future<void> updateUsername() async {
    try {
      UFullScreenLoader.openLoadingDialog(
        'We are updating your information...',
      );

      // connectivity
      bool isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected){
       UFullScreenLoader.stopLoading();
       return;
      }
      if (!updateUserFormKey.currentState!.validate()) {
        UFullScreenLoader.stopLoading();
        return;
      }
      Map<String,dynamic>map={
        'firstName':firstName.text,
        'lastName':lastName.text,
      };
     await _userRepository.updateSingleField(map);

     _userController.user.value.firstName=firstName.text;
     _userController.user.value.lastName=lastName.text;
     
     UFullScreenLoader.stopLoading();
     Get.offAll(()=>NavigationMenu());
     USnackBarHelpers.successSnackBar(title: 'Congratulations',message: 'Your name has been updated');

      
      
    } catch (e) {
      UFullScreenLoader.stopLoading();
      USnackBarHelpers.warningSnackBar(
        title: 'Update Name Failed',
        message: e.toString(),
      );
    }
  }
}
