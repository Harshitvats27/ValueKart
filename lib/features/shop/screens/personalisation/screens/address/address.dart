import 'package:e_commerce_application/common/style/padding.dart';
import 'package:e_commerce_application/common/widgets/appbar/appbar.dart';
import 'package:e_commerce_application/common/widgets/custom_shape/rounded_container.dart';
import 'package:e_commerce_application/features/personalisation/models/address_model.dart';
import 'package:e_commerce_application/features/shop/screens/personalisation/screens/address/new_address.dart';
import 'package:e_commerce_application/features/shop/screens/personalisation/screens/address/widgets/single_address.dart';
import 'package:e_commerce_application/utils/constants/colors.dart';
import 'package:e_commerce_application/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../utils/helpers/cloud_helper_functions.dart';
import '../../../../../personalisation/controllers/address_controller.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());
    return Scaffold(
      appBar: UAppBar(
        title: Text(
          'Addresses',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: UPadding.screenPadding,
          child: Obx(
              ()=> FutureBuilder(
                key:Key(controller.refreshData.value.toString()),
              future: controller.getAllAddresses(),
              builder: (context, snapshot) {
                // handle error and loader
                final widget = UCloudHelperFunctions.checkMultiRecordState(
                  snapshot: snapshot,
                );
                if (widget != null) return widget;
                List<AddressModel> addresses = snapshot.data!;
                return ListView.separated(
                  itemBuilder: (context, index) {
                    return USingleAddress(
                      onTap: () => controller.selectAddress(addresses[index]),
                    addresses: addresses[index],
                    );
                  },
                  separatorBuilder: (context, index) =>
                      SizedBox(height: USizes.spaceBtwItems),
                  itemCount: addresses.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                );
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => AddNewAddressScreen()),
        backgroundColor: UColors.primary,
        child: Icon(Iconsax.add, color: UColors.white),
      ),
    );
  }
}
