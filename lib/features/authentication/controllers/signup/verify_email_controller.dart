import 'dart:async';

import 'package:e_commerce_application/common/data/repositories/authentication_repository.dart';
import 'package:e_commerce_application/common/widgets/screeens/success_screen.dart';
import 'package:e_commerce_application/utils/constants/images.dart';
import 'package:e_commerce_application/utils/pop_ups/snackbar_helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/text.dart';

class VerifyEmailController extends GetxController{
  static VerifyEmailController get instance => Get.find();

  @override
  void onInit() {
    sendEmailVerification();
    setTimerForAutoRedirect();
    super.onInit();
  }
// Send Email Verification
 Future<void> sendEmailVerification() async {
    try{
      await AuthenticationReposiotory.instance.sendEmailVerification();
      USnackBarHelpers.successSnackBar(title: 'Email Sent',message:'Please Check Your Inbox and Verify your Email' );

    }catch(e){

      USnackBarHelpers.errorSnackBar(title: 'Error',message:e.toString());
    }
 }

  Future<void> setTimerForAutoRedirect()async {
    Timer.periodic(Duration(seconds: 1), (timer) async {
      FirebaseAuth.instance.currentUser!.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user?.emailVerified ?? false) {
        timer.cancel();
        Get.off(() =>
            SuccessScreen(
                title: UTexts.accountCreatedTitle,
                subTitle: UTexts.accountCreatedSubTitle,
                image: UImages.successfulPaymentIcon,
                onTap: () =>
                    AuthenticationReposiotory.instance.screenRedirect()));
      }
    });
  }


  Future<void>checkEmailVerification()async{
    try{
  final currentUser= FirebaseAuth.instance.currentUser;
  if(currentUser!=null&& currentUser.emailVerified){ Get.off(() =>
      SuccessScreen(
          title: UTexts.accountCreatedTitle,
          subTitle: UTexts.accountCreatedSubTitle,
          image: UImages.successfulPaymentIcon,
          onTap: () =>
              AuthenticationReposiotory.instance.screenRedirect()));


  }
    }catch(e){

    }
  }
}