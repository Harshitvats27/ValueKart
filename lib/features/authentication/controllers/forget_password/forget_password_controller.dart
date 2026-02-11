import 'package:e_commerce_application/common/data/repositories/authentication_repository.dart';
import 'package:e_commerce_application/utils/pop_ups/full_screen_loader.dart';
import 'package:e_commerce_application/utils/pop_ups/snackbar_helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../utils/helpers/network_manager.dart';
import '../../screens/forget_password/reset_passworrd.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  // variables
  final email = TextEditingController();
  final forgetPasswrdFormKey = GlobalKey<FormState>();

  // Send email to forget password

  Future<void> sendPasswordResetEmail() async {
    try {
      UFullScreenLoader.openLoadingDialog('Processing Your Request....');
      // check internet connectivity
      bool isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        UFullScreenLoader.stopLoading();
        USnackBarHelpers.warningSnackBar(title: 'No Internet Connection');
        return;
      }

      // form validation
      if (!forgetPasswrdFormKey.currentState!.validate()) {
        UFullScreenLoader.stopLoading();
        return;
      }
      AuthenticationReposiotory.instance.sendPassswordResetEmail(email.text);

      // stop loading
      UFullScreenLoader.stopLoading();
      USnackBarHelpers.successSnackBar(
        title: 'Email Sent',
        message: 'Email Link Sent to Reset your Password',
      );

      // Redirect
      Get.to(() => ResetPassworrdScreen(email: email.text.trim()));
    } catch (e) {
      UFullScreenLoader.stopLoading();
      USnackBarHelpers.errorSnackBar(
        title: 'Failed Forget Password',
        message: e.toString(),
      );
    }
  }

  Future<void> resendPasswordResetEmail() async {
    try {
      UFullScreenLoader.openLoadingDialog('Processing Your Request....');
      // check internet connectivity
      bool isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        UFullScreenLoader.stopLoading();
        USnackBarHelpers.warningSnackBar(title: 'No Internet Connection');
        return;
      }

      AuthenticationReposiotory.instance.sendPassswordResetEmail(email.text);

      // stop loading
      UFullScreenLoader.stopLoading();
      USnackBarHelpers.successSnackBar(
        title: 'Email Sent',
        message: 'Email Link Sent to Reset your Password',
      );
    } catch (e) {
      UFullScreenLoader.stopLoading();
      USnackBarHelpers.errorSnackBar(
        title: 'Failed Forget Password',
        message: e.toString(),
      );
    }
  }
}
