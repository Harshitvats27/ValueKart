import 'package:e_commerce_application/common/widgets/custom_shape/rounded_container.dart';
import 'package:e_commerce_application/common/widgets/loaders/animation_loader.dart';
import 'package:e_commerce_application/features/shop/models/order_model.dart';
import 'package:e_commerce_application/utils/constants/colors.dart';
import 'package:e_commerce_application/utils/constants/images.dart';
import 'package:e_commerce_application/utils/helpers/cloud_helper_functions.dart';
import 'package:e_commerce_application/utils/helpers/device_helpers.dart';
import 'package:e_commerce_application/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';


import '../../../../../navigation_menu.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/order/order_controller.dart';

class UOrderListItems extends StatelessWidget {
  const UOrderListItems({super.key});

  @override
  Widget build(BuildContext context) {
    final dark=UHelperfunctions.isDarkTheme(context);
    final controller = Get.put(OrderController());
    return FutureBuilder(
        future: controller.fetchUserOrders(),
        builder: (context,snapshot){
          
          final nothingFound = UAnimationLoader(text: 'No Orders Yet',showActionButton: true,actionText: "Let's Fill it",animation: UImages.pencilAnimation,onActionPressed: ()=>Get.offAll(()=>NavigationMenu()),);
          final widget =UCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot,nothingFound: nothingFound);
          if(widget!=null) return widget;
          List<OrderModel> orders = snapshot.data!;
          return ListView.separated(
              separatorBuilder: (context,index)=>SizedBox(height: USizes.spaceBtwItems,),
              itemCount:orders.length,
              itemBuilder: (context,index){
                OrderModel order = orders[index];
                return URoundedContainer(
                  showBorder: true,
                  backgroundColor: dark? UColors.dark:UColors.light,
                  padding: EdgeInsets.all(USizes.sm),
                  child: Padding(
                    padding: const EdgeInsets.all(USizes.md),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Icon(Iconsax.ship),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(order.orderStatusText,style: Theme.of(context).textTheme.bodyLarge!.apply(color: UColors.primary,fontWeightDelta:1 ),),
                                  Text(order.formattedOrderDate,style: Theme.of(context).textTheme.headlineSmall,)
                                ],
                              ),
                            ),

                            IconButton(onPressed: (){}, icon: Icon(Iconsax.arrow_right_34,size: USizes.iconSm,))
                          ],
                        ),
                        SizedBox(height: USizes.spaceBtwItems,),
                        Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Icon(Iconsax.tag),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Order',style: Theme.of(context).textTheme.labelMedium,),
                                        Text(order.id,style: Theme.of(context).textTheme.headlineSmall,)
                                      ],
                                    ),
                                  ),

                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  Icon(Iconsax.calendar),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Shipping Date',style: Theme.of(context).textTheme.labelMedium,),
                                        Text(order.formattedDeliveryDate,style: Theme.of(context).textTheme.headlineSmall,)
                                      ],
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ],
                        )

                      ],
                    ),
                  ),


                );
              });
        }
    );
  }
}
