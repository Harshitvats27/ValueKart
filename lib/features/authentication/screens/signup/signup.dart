import 'package:e_commerce_application/common/style/padding.dart';
import 'package:e_commerce_application/common/widgets/button/elevated_button.dart';
import 'package:e_commerce_application/common/widgets/button/special_buttons.dart';
import 'package:e_commerce_application/common/widgets/login_signup/form_divider.dart';
import 'package:e_commerce_application/features/authentication/screens/signup/widgets/signup_form.dart';
import 'package:e_commerce_application/utils/constants/colors.dart';
import 'package:e_commerce_application/utils/constants/sizes.dart';
import 'package:e_commerce_application/utils/constants/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

import '../../controllers/signup/sign_up_controller.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: UPadding.screenPadding,
          child: Column(
            children: [
              // Header
              Text(
                UTexts.signupTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(height: USizes.spaceBtwSections),
              // Form
              USignupForm(),
              SizedBox(height: USizes.spaceBtwSections),

              // Divider
            UFormDivider(title:UTexts.orSignupWith),
              SizedBox(height: USizes.spaceBtwSections),

              // Footer
              USpecialButtoms(),
            ],
          ),
        ),
      ),
    );
  }
}
