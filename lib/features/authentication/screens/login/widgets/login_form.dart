import 'package:e_commerce_application/features/authentication/controllers/login/login_controller.dart';
import 'package:e_commerce_application/features/authentication/screens/login/login.dart';
import 'package:e_commerce_application/navigation_menu.dart';
import 'package:e_commerce_application/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/button/elevated_button.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text.dart';
import '../../forget_password/forget_password.dart';
import '../../signup/signup.dart';

class ULoginForm extends StatelessWidget {
  const ULoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = LoginController.instance;
    return Form(
      key: controller.loginFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // email
          TextFormField(
            validator: (value) => UValidator.validateEmail(value),
            controller: controller.email,
            decoration: InputDecoration(
              prefixIcon: Icon(Iconsax.direct_right),
              labelText: UTexts.email,
            ),
          ),
          SizedBox(height: USizes.spaceBtwInputFields),

          // password
          Obx(()=>
             TextFormField(
              controller: controller.password,
              validator: (value) => UValidator.validateEmptyText('Password',value),
              obscureText: controller.isPasswordVisible.value,
              decoration: InputDecoration(
                prefixIcon: Icon(Iconsax.password_check),
                labelText: UTexts.password,
                suffixIcon: IconButton(
                  onPressed: ()=>controller.isPasswordVisible.toggle(),
                  icon: Icon(
                    controller.isPasswordVisible.value
                        ? Iconsax.eye_slash
                        : Iconsax.eye,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: USizes.spaceBtwInputFields / 2),

          // remember me and Forgot Password
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Obx(()=> Checkbox(value: controller.rememberMe.value, onChanged: (value)=>controller.rememberMe.toggle())),
                  Text(UTexts.rememberMe),
                ],
              ),

              // Forgot Password
              TextButton(
                onPressed: () => Get.to(() => ForgetPassword()),
                child: Text(UTexts.forgetPassword),
              ),
            ],
          ),
          SizedBox(height: USizes.spaceBtwSections),

          // sign in
          UElevatedButton(
            onPressed: () => controller.loginWithEmailandPassword(),
            child: Text(UTexts.signIn),
          ),

          SizedBox(height: USizes.spaceBtwSections / 2),

          // cretae Account
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () => Get.to(() => SignupScreen()),
              child: Text(UTexts.createAccount),
            ),
          ),
        ],
      ),
    );
  }
}
