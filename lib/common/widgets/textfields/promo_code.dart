
import 'package:e_commerce_application/utils/helpers/helper_function.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../custom_shape/rounded_container.dart';

class UPromoCodeField extends StatelessWidget {
  const UPromoCodeField({
    super.key,

  });



  @override
  Widget build(BuildContext context) {
    final dark =UHelperfunctions.isDarkTheme(context);
    return URoundedContainer(
      showBorder: true,
      backgroundColor: Colors.transparent,
      padding: EdgeInsets.only(
        bottom: USizes.sm,
        left: USizes.sm,
        right: USizes.sm,
        top: USizes.sm,
      ),
      child: Row(
        children: [
          Flexible(
            child: TextFormField(
              decoration: InputDecoration(
                hintText: 'Have a PromoCode? Enter Here',
                border:InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,

              ),
            ),
          ),
          SizedBox(
            width:80 ,
            child: ElevatedButton(onPressed: (){},
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.withValues(alpha: 0.2),
                  foregroundColor: dark?UColors.white.withValues(alpha: 0.5):UColors.dark.withValues(alpha: 0.5),
                  side: BorderSide(
                      color: Colors.grey.withValues(alpha: 0.1),
                  )
              ),
              child: Text('Apply'),
            ),
          )
        ],
      ),
    );
  }
}
