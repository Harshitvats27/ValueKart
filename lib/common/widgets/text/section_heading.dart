

import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/text.dart';

class USectionHeading extends StatelessWidget {
  const USectionHeading({
    super.key, required this.title,  this.buttonTitle='View All', this.onPressed,  this.showActionButtton=true,
  });

  final String title,buttonTitle;
  final void Function()? onPressed;
  final bool showActionButtton;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: Theme
            .of(context)
            .textTheme
            .headlineSmall,maxLines: 1,overflow: TextOverflow.ellipsis,),
        if(showActionButtton) TextButton(onPressed: onPressed, child: Text(buttonTitle,)),

      ],
    );
  }
}
