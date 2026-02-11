import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_application/common/style/padding.dart';
import 'package:e_commerce_application/common/widgets/button/elevated_button.dart';
import 'package:e_commerce_application/features/authentication/screens/forget_password/reset_passworrd.dart';
import 'package:e_commerce_application/utils/constants/sizes.dart';
import 'package:e_commerce_application/utils/constants/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/validators/validation.dart';
import '../../controllers/forget_password/forget_password_controller.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: UPadding.screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              // Title
              Text(
                UTexts.forgetPasswordTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(height: USizes.spaceBtwItems / 2),
              // Sub title
              Text(
                UTexts.forgetPasswordSubTitle,
                style: Theme.of(context).textTheme.labelMedium,
              ),
              SizedBox(height: USizes.spaceBtwSections * 2),

              // Form
              Column(
                children: [
                  Form(
                    key: controller.forgetPasswrdFormKey,
                  child: TextFormField(
                      controller: controller.email,
                      validator: (value) => UValidator.validateEmail(value),
                      decoration: InputDecoration(
                        labelText: UTexts.email,
                        prefixIcon: Icon(Iconsax.direct_right),
                      ),
                    ),
                  ),
                  SizedBox(height: USizes.spaceBtwItems),

                  UElevatedButton(
                    onPressed: () => controller.sendPasswordResetEmail(),
                    child: Text(UTexts.submit),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
