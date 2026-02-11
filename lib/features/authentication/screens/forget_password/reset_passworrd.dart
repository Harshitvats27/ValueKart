import 'package:e_commerce_application/common/style/padding.dart';
import 'package:e_commerce_application/common/widgets/button/elevated_button.dart';
import 'package:e_commerce_application/features/authentication/controllers/forget_password/forget_password_controller.dart';
import 'package:e_commerce_application/utils/constants/sizes.dart';
import 'package:e_commerce_application/utils/helpers/device_helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

import '../../../../utils/constants/images.dart';
import '../../../../utils/constants/text.dart';
import '../login/login.dart';

class ResetPassworrdScreen extends StatelessWidget {
  const ResetPassworrdScreen({super.key, required this.email});
final String email;

  @override
  Widget build(BuildContext context) {
    final controller = ForgetPasswordController.instance;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => Get.offAll(() => LoginScreen()),
            icon: Icon(Icons.close),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: UPadding.screenPadding,
          child: Column(
            children: [
              // Image
              Image.asset(
                UImages.mailSentImage,
                height: UDeviceHelper.getScreenWidth(context) * 0.9,
              ),
              SizedBox(height: USizes.spaceBtwItems,),
              // Title
              Text(
                UTexts.resetPasswordTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(height: USizes.spaceBtwItems,),
              // Email
              Text(
                email,style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: USizes.spaceBtwItems,),
              //sub title
              Text(
                UTexts.resetPasswordSubTitle,
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: USizes.spaceBtwSections,),

              // Done
              UElevatedButton(onPressed:()=>Get.offAll(LoginScreen()), child: Text(UTexts.done)),

              // resend email
              SizedBox(
                  width: double.infinity,
                  child: TextButton(onPressed: controller.resendPasswordResetEmail, child: Text(UTexts.resendEmail))),
            ],
          ),
        ),
      ),
    );
  }
}
