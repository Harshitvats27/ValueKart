import 'package:e_commerce_application/features/shop/controllers/controller/all_products_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../features/shop/models/product_model.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../layout/grid_layout.dart';
import '../product_cards/product_cards_vertical.dart';

class USortableProducts extends StatelessWidget {
  const USortableProducts({super.key, required this.product});

  final List<ProductModel> product;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductsController());
    controller.assignProducts(product);
    return Column(
      children: [
        DropdownButtonFormField(
          value: controller.selectedSortOption.value,
          decoration: InputDecoration(prefixIcon: Icon(Iconsax.sort)),
          onChanged: (value)=>controller.sortProducts(value!),

          items: ['Name', 'Lower Price', 'Higher Price', 'Sale', 'Newest'].map((
            filter,
          ) {
            return DropdownMenuItem(value: filter, child: Text(filter));
          }).toList(),
        ),
        SizedBox(height: USizes.spaceBtwSections),
        Obx(
          () =>
           UGridLayout(
            itemCount: controller.products.length,
            itemBuilder: (context, index) {
              return UProductcardVertical(productModel: controller.products[index]);
            },
          ),
        ),
      ],
    );
  }
}
