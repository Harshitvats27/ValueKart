import 'package:flutter/material.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/helpers/helper_function.dart';

class UEmptyStateWidget extends StatelessWidget {
  const UEmptyStateWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.subTitle,
    this.showAction = false, // 🔥 Optional button
    this.actionTitle,
    this.onActionPressed,
  });

  final IconData icon;
  final String title;
  final String subTitle;
  final bool showAction;
  final String? actionTitle;
  final VoidCallback? onActionPressed;

  @override
  Widget build(BuildContext context) {
    final dark = UHelperfunctions.isDarkTheme(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 64,
              color: dark ? UColors.light.withOpacity(0.8) : UColors.dark.withOpacity(0.8),
            ),
            const SizedBox(height: USizes.spaceBtwItems),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall!.apply(
                color: dark ? UColors.white : UColors.dark,
              ),
            ),
            const SizedBox(height: USizes.spaceBtwItems / 2),
            Text(
              subTitle,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium!.apply(color: UColors.grey),
            ),

            // 🔥 NAYA: Pan-India Explore Button
            if (showAction && actionTitle != null && onActionPressed != null) ...[
              const SizedBox(height: USizes.spaceBtwSections),
              SizedBox(
                width: 250,
                child: ElevatedButton.icon(
                  onPressed: onActionPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: UColors.primary,
                    side: const BorderSide(color: UColors.primary),
                  ),
                  icon: const Icon(Icons.public, color: UColors.white),
                  label: Text(actionTitle!, style: const TextStyle(color: UColors.white)),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}