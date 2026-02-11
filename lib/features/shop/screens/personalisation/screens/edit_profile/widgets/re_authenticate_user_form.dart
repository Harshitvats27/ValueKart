import 'package:e_commerce_application/common/style/padding.dart';
import 'package:e_commerce_application/common/widgets/appbar/appbar.dart';
import 'package:e_commerce_application/common/widgets/button/elevated_button.dart';
import 'package:e_commerce_application/features/personalisation/controllers/user_controller.dart';
import 'package:e_commerce_application/utils/constants/sizes.dart';
import 'package:e_commerce_application/utils/constants/text.dart';
import 'package:e_commerce_application/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ReAuthenticateUserFormScreen extends StatelessWidget {
  const ReAuthenticateUserFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return Scaffold(
      appBar: UAppBar(title: Text('Re-Authenticate User'), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: UPadding.screenPadding,
          child: Form(
            key: controller.reAuthFormKey,
            child: Column(
              children: [
                // email
                TextFormField(
                  controller: controller.email,
                  validator: UValidator.validateEmail,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Iconsax.direct_right),
                    labelText: UTexts.email,
                  ),
                ),
                SizedBox(height: USizes.spaceBtwItems),
                Obx(
                  () => TextFormField(
                    controller: controller.password,
                    obscureText: !controller.isPasswordVisible.value,
                    validator: (value) =>
                        UValidator.validateEmptyText('Password', value),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Iconsax.password_check),
                      labelText: UTexts.password,
                      suffixIcon: IconButton(
                        onPressed: () => controller.isPasswordVisible.toggle(),
                        icon: Icon(
                          controller.isPasswordVisible.value
                              ? Iconsax.eye_slash
                              : Iconsax.eye,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: USizes.spaceBtwSections),
                UElevatedButton(
                  onPressed: controller.confirmEmailPasswordReAuthAndDelete,
                  child: Text('Verify'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
