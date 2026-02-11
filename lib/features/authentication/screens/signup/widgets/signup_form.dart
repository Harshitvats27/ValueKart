import 'package:e_commerce_application/features/authentication/screens/signup/verify_email.dart';
import 'package:e_commerce_application/features/authentication/screens/signup/widgets/privacy_policy_checkbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/button/elevated_button.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text.dart';
import '../../../../../utils/validators/validation.dart';
import '../../../controllers/signup/sign_up_controller.dart';

class USignupForm extends StatelessWidget {
  const USignupForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SignupController.instance;
    return Form(
      key: controller.signUpFormKey,
      child: Column(
        children: [
          // first name and last name
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller.firstName,
                  validator: (value) =>
                      UValidator.validateEmptyText('First Name', value),
                  decoration: InputDecoration(
                    labelText: UTexts.firstName,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),
              SizedBox(width: USizes.spaceBtwInputFields),
              Expanded(
                child: TextFormField(
                  controller: controller.lastName,
                  validator: (value) =>
                      UValidator.validateEmptyText('Last Name', value),
                  decoration: InputDecoration(
                    labelText: UTexts.lastName,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: USizes.spaceBtwInputFields),

          //email
          TextFormField(
            controller: controller.email,
            validator: (value) => UValidator.validateEmail(value),
            decoration: InputDecoration(
              labelText: UTexts.email,
              prefixIcon: Icon(Iconsax.direct_right),
            ),
          ),
          SizedBox(height: USizes.spaceBtwInputFields),

          // phone
          TextFormField(
            controller: controller.phoneNumber,
            validator: (value) => UValidator.validatePhoneNumber(value),
            decoration: InputDecoration(
              labelText: UTexts.phoneNumber,
              prefixIcon: Icon(Iconsax.call),
            ),
          ),
          SizedBox(height: USizes.spaceBtwInputFields),

          // password
          Obx(
            () => TextFormField(
              obscureText: controller.isPasswordVisible.value,

              controller: controller.password,
              validator: (value) => UValidator.validatePassword(value),
              decoration: InputDecoration(
                labelText: UTexts.password,
                prefixIcon: Icon(Iconsax.eye),
                suffixIcon: IconButton(
                  onPressed: () => controller.isPasswordVisible.value =
                      !controller.isPasswordVisible.value,
                  icon: Icon(
                    controller.isPasswordVisible.value
                        ? Iconsax.eye
                        : Iconsax.eye_slash,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: USizes.spaceBtwInputFields / 2),

          // privacy policy and checkbox
          PrivacyPolicyCheckbox(),
          SizedBox(height: USizes.spaceBtwItems),
          // create Account
          UElevatedButton(
            onPressed: controller.registerUser,
            child: Text(UTexts.createAccount),
          ),
        ],
      ),
    );
  }
}
