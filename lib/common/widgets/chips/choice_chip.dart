
import 'package:e_commerce_application/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../custom_shape/circular_contaner.dart';
import '../shimmer/shimmer_effect.dart';

class UChoiceChip extends StatelessWidget {
  const UChoiceChip({
    super.key,
    required this.text,
    required this.selected,
    required this.onSelected,
  });

  final String text;
  final bool selected;
  final Function(bool)? onSelected;

  @override
  Widget build(BuildContext context) {
    bool isColor = UHelperfunctions.getColor(text) != null;
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
      child: ChoiceChip(
        label: isColor ? SizedBox() : Text(text),
        selected: selected,
        onSelected: onSelected,
        labelStyle: TextStyle(color: selected ? UColors.white : null),
        shape: isColor ? CircleBorder() : null,
        padding: isColor ? EdgeInsets.zero : null,
        labelPadding: isColor ? EdgeInsets.zero : null,
        avatar: isColor ? UCircularContaimer.UCircularContainer(width: 50.0, height: 50.0, backgroundColor: UHelperfunctions.getColor(text)!) : null,
        backgroundColor: isColor ? UHelperfunctions.getColor(text) : null,
      ),
    );
  }
}