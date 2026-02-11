
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../features/shop/models/product_model.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../layout/grid_layout.dart';
import '../product_cards/product_cards_vertical.dart';

class USortableProducts extends StatelessWidget {
  const USortableProducts({
    super.key, required this.product,
  });
final List<ProductModel>product;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButtonFormField(
          decoration: InputDecoration(prefixIcon: Icon(Iconsax.sort)),
          onChanged: (value) {},

          items: ['Name', 'Lower Price'].map((filter) {
            return DropdownMenuItem(value: filter, child: Text(filter));
          }).toList(),
        ),
        SizedBox(height: USizes.spaceBtwSections),
        UGridLayout(itemCount: 23, itemBuilder: (context, index) {
          return UProductcardVertical(productModel:ProductModel.empty() ,);
        })
      ],
    );
  }
}
