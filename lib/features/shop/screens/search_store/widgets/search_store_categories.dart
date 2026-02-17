import 'package:e_commerce_application/features/shop/screens/all_products/all_products.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/images/rounded_image.dart';
import '../../../../../common/widgets/text/section_heading.dart';
import '../../../../../utils/constants/images.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/categories/category_controller.dart';
import '../../../models/category_model.dart';

class SearchStoreCategories extends StatelessWidget {
  const SearchStoreCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      }
      if (controller.categories.isEmpty) {
        return Center(child: Text('No Categories Found'));
      }
      List<CategoryModel> categories = controller.categories;
      return Column(
        children: [
          USectionHeading(title: 'Categories', showActionButtton: false,),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
             CategoryModel category = categories[index];
              return ListTile(
                onTap: ()=>Get.to(()=>AllProductsScreen(title: category.name,futureMethod: controller.getCategoryProducts(categoryId: category.id),)),
                contentPadding: EdgeInsets.zero,
                leading: URoundedImage(
                  imageUrl: category.image,
                  borderRadius: 0,
                  width: USizes.iconLg,
                  height: USizes.iconLg,
                  isNetworkImage: true,
                ),
                title: Text(
                  category.name,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              );
            },

            itemCount: categories.length,
          ),
        ],
      );
    });
  }
}
