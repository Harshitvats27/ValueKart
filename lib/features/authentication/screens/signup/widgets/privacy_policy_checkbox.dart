
import 'package:e_commerce_application/features/authentication/controllers/signup/sign_up_controller.dart';
import 'package:e_commerce_application/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/text.dart';

class PrivacyPolicyCheckbox extends StatelessWidget {
  const PrivacyPolicyCheckbox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = UHelperfunctions.isDarkTheme(context);
    final controller = SignupController.instance;
    return Row(
      children: [
        Obx(()=> Checkbox(value: controller.privacyPolicy.value, onChanged: (value)=>controller.privacyPolicy.value=!controller.privacyPolicy.value)),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.bodyMedium,
              children: [
                TextSpan(text: '${UTexts.iAgreeTo} '),
                TextSpan(
                  text: '${UTexts.privacyPolicy} ',
                  style: Theme.of(context).textTheme.bodyMedium!
                      .copyWith(
                    color: dark? UColors.white:UColors.primary,
                    // decoration: TextDecoration.underline,
                  ),
                ),
                TextSpan(text: '${UTexts.and} '),

                TextSpan(
                  text: '${UTexts.termsOfUse} ',
                  style: Theme.of(context).textTheme.bodyMedium!
                      .copyWith(
                    color: dark? UColors.white:UColors.primary,
                    //decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
