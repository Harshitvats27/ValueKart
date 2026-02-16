import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_application/common/data/repositories/authentication_repository.dart';
import 'package:e_commerce_application/common/widgets/loaders/circular_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/widgets/text/section_heading.dart';
import '../../../data/repositories/address/address_repository.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/cloud_helper_functions.dart';
import '../../../utils/helpers/network_manager.dart';
import '../../../utils/pop_ups/full_screen_loader.dart';
import '../../../utils/pop_ups/snackbar_helpers.dart';
import '../../shop/screens/personalisation/screens/address/widgets/single_address.dart';
import '../models/address_model.dart';

class AddressController extends GetxController {
  static AddressController get instance => Get.find();

  final _repository = Get.put(AddressRepository());
  Rx<AddressModel> selectedAddress = AddressModel.empty().obs;
  RxBool refreshData = false.obs;

  /// Text Controllers
  final name = TextEditingController();
  final phoneNumber = TextEditingController();
  final street = TextEditingController();
  final postalCode = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final country = TextEditingController();

  /// Form Key
  final GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();

  Future<void> addNewAddress() async {
    try {
      // Start Loading
      UFullScreenLoader.openLoadingDialog('Storing Address...');

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        UFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!addressFormKey.currentState!.validate()) {
        UFullScreenLoader.stopLoading();
        return;
      }

      // Create Address Model
      AddressModel address = AddressModel(
        id: '',
        name: name.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        street: street.text.trim(),
        city: city.text.trim(),
        state: state.text.trim(),
        postalCode: postalCode.text.trim(),
        country: country.text.trim(),
        selectedAddress: true,
        dateTime: DateTime.now(),
      );

      String addressId = await _repository.addAddress(address);
      address.id = addressId;
      // update selected address
      selectAddress(address);

      // Stop Loading
      UFullScreenLoader.stopLoading();
      // Reset Form Fields
      resetFormFields();
      Navigator.pop(Get.context!);
      Navigator.pop(Get.context!);
      // Success Message
      USnackBarHelpers.successSnackBar(
        title: 'Success',
        message: 'Address saved successfully',
      );
      refreshData.toggle();
    } catch (e) {
      UFullScreenLoader.stopLoading();
      USnackBarHelpers.errorSnackBar(title: 'Error', message: e.toString());
    }
  }

  Future<List<AddressModel>> getAllAddresses() async {
    try {
      List<AddressModel> addresses = await _repository.fetchUserAddresses();
      selectedAddress.value = addresses.firstWhere(
        (element) => element.selectedAddress,
        orElse: () => AddressModel.empty(),
      );
      return addresses;
    } catch (e) {
      USnackBarHelpers.errorSnackBar(title: 'Error', message: e.toString());
      return [];
    }
  }

  void resetFormFields() {
    name.text = '';
    phoneNumber.text = '';
    street.text = '';
    postalCode.text = '';
    city.text = '';
    state.text = '';
    country.text = '';

    addressFormKey.currentState?.reset();

    update(); // 🔥 VERY IMPORTANT (if using GetBuilder)
  }

  Future<void> selectAddress(AddressModel newSelectedAddress) async {
    try {
      Get.defaultDialog(
        title: '',
        onWillPop: () async => false,
        barrierDismissible: false,
        backgroundColor: Colors.transparent,
        content: UCircularLoader(),
      );
      if (selectedAddress.value.id.isNotEmpty) {
        await _repository.updateSelectedField(selectedAddress.value.id, false);
      }

      newSelectedAddress.selectedAddress = true;
      selectedAddress.value = newSelectedAddress;
      await _repository.updateSelectedField(selectedAddress.value.id, true);
      Get.back();
    } catch (e) {
      Get.back();
      USnackBarHelpers.errorSnackBar(title: 'Error', message: e.toString());
    }
  }

  Future<void> selectNewAddressBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) => SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(USizes.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Heading
              USectionHeading(title: 'Select Address', showActionButtton: false),

              SizedBox(height: USizes.spaceBtwItems),

              /// Address List
              FutureBuilder(
                future: getAllAddresses(),
                builder: (context, snapshot) {
                  /// Handle Error, Loading, Empty States
                  final widget = UCloudHelperFunctions.checkMultiRecordState(
                    snapshot: snapshot,
                  );

                  if (widget != null) return widget;

                  return ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    separatorBuilder: (_, __) =>
                        SizedBox(height: USizes.spaceBtwItems),
                    itemBuilder: (context, index) => USingleAddress(
                      addresses: snapshot.data![index],
                      onTap: () {
                        selectedAddress(snapshot.data![index]);
                        Get.back();
                      },
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
