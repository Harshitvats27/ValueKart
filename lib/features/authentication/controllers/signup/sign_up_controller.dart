import 'package:e_commerce_application/features/authentication/models/user_model.dart';
import 'package:e_commerce_application/utils/helpers/network_manager.dart';
import 'package:e_commerce_application/utils/pop_ups/full_screen_loader.dart';
import 'package:e_commerce_application/utils/pop_ups/snackbar_helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../common/data/repositories/authentication_repository.dart';
import '../../../../common/data/repositories/user/user_repository.dart';
import '../../screens/signup/verify_email.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  // variables

  final signUpFormKey = GlobalKey<FormState>();
  RxBool isPasswordVisible = true.obs;
  RxBool privacyPolicy = false.obs;

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final phoneNumber = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();

  // Function to Register the user with email and password
  Future<void> registerUser() async {
    try {
      // // Start Loading
      // UFullScreenLoader.openLoadingDialog(
      //   'We are processing your information.....',
      // );
      //
      // // Check Internet Connectivity
      // bool isConnected = await NetworkManager.instance.isConnected();
      // if (!isConnected) {
      //   UFullScreenLoader.stopLoading();
      //   USnackBarHelpers.warningSnackBar(title: 'No Internet Connection');
      //   return;
      // }
      // // Form Validation
      // if (!signUpFormKey.currentState!.validate()) {
      //   return;
      // }
      // // Check Privacy Policy
      // if (!privacyPolicy.value) {
      //   UFullScreenLoader.stopLoading();
      //   USnackBarHelpers.warningSnackBar(
      //     title:'Accept Privacy Policy',
      //         message:
      //         'In Order to Create Account You must have to enter the Privacy Policy',
      //   );
      //   return;
      // }

      // 1️⃣ Form Validation FIRST
      if (!signUpFormKey.currentState!.validate()) {
        return;
      }

      // 2️⃣ Privacy Policy Check
      if (!privacyPolicy.value) {
        USnackBarHelpers.warningSnackBar(
          title: 'Accept Privacy Policy',
          message: 'You must accept the privacy policy to continue',
        );
        return;
      }

      // 3️⃣ Internet Check
      bool isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        USnackBarHelpers.warningSnackBar(title: 'No Internet Connection');
        return;
      }

      // 4️⃣ NOW show loader ✅
      UFullScreenLoader.openLoadingDialog(
        'We are processing your information.....',
      );

      UserCredential userCredential = await AuthenticationReposiotory.instance
          .registerUser(email.text.trim(), password.text.trim());

      UserModel userModel = UserModel(
        id: userCredential.user!.uid,
        firstName: firstName.text,
        lastName: lastName.text,
        username: '_${firstName.text}${lastName.text}',
        email: email.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        profilePicture: '',
      );

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(userModel);

      USnackBarHelpers.successSnackBar(
        title: 'Congratulations',
        message: 'Your account has been created! Verify email to continue',
      );

      // stop loading
      UFullScreenLoader.stopLoading();

      // redirect to verify email screen
      Get.to(() => VerifyEmailScreen(email:email.text ,));
    } catch (e) {
      UFullScreenLoader.stopLoading();
      USnackBarHelpers.errorSnackBar(title: 'Error', message: e.toString());
    }
  }
}
