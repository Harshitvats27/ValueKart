import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../common/layout/grid_layout.dart';
import '../../../../common/style/padding.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/products/product_cards/product_cards_vertical.dart';
import '../../../../common/widgets/shimmer/vertical_product_shimmer.dart';
import '../../../../data/repositories/product_repository.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import 'features/shop/models/product_model.dart';

class PanIndiaCatalogScreen extends StatelessWidget {
  const PanIndiaCatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const UAppBar(
        showBackArrow: true,
        title: Text('Pan-India Showcase 🌍'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: UPadding.screenPadding,
          child: Column(
            children: [
              // 🔥 Info Banner for User
              Container(
                padding: const EdgeInsets.all(USizes.md),
                decoration: BoxDecoration(
                  color: UColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(USizes.cardRadiusLg),
                  border: Border.all(color: UColors.primary.withOpacity(0.4)),
                ),
                child: Row(
                  children: [
                    const Icon(Iconsax.info_circle, color: UColors.primary, size: 28),
                    const SizedBox(width: USizes.spaceBtwItems),
                    Expanded(
                      child: Text(
                        'These products are available outside your 10 KM zone. To order anywhere in India, contact us via email!',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: USizes.spaceBtwSections),

              // 🔥 Fetch ALL Products (No 10 KM Filter)
              FutureBuilder<List<ProductModel>>(
                future: ProductRepository.instance.fetchAllProducts(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const UVerticalProductShimmer(itemCount: 6);
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No products found in the catalog.'));
                  }

                  final products = snapshot.data!;
                  return UGridLayout(
                    itemCount: products.length,
                    itemBuilder: (context, index) => UProductcardVertical(
                      productModel: products[index],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}