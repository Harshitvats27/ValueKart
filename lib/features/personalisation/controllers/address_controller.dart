import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:e_commerce_application/common/widgets/loaders/circular_loader.dart';
import 'package:e_commerce_application/common/widgets/text/section_heading.dart';
import 'package:e_commerce_application/utils/constants/sizes.dart';
import 'package:e_commerce_application/utils/helpers/cloud_helper_functions.dart';
import 'package:e_commerce_application/utils/helpers/network_manager.dart';
import 'package:e_commerce_application/utils/pop_ups/full_screen_loader.dart';
import 'package:e_commerce_application/utils/pop_ups/snackbar_helpers.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';

import '../../../data/repositories/address/address_repository.dart';
import '../../../utils/helpers/u_empty_state_widget.dart';
import '../../shop/screens/personalisation/screens/address/new_address.dart';
import '../../shop/screens/personalisation/screens/address/widgets/single_address.dart';
import '../models/address_model.dart';

class AddressController extends GetxController {
  static AddressController get instance => Get.find();

  final _repository = Get.put(AddressRepository());
  Rx<AddressModel> selectedAddress = AddressModel.empty().obs;
  RxBool refreshData = false.obs;
  GoogleMapController? googleMapController;
  /// Text Controllers
  final name = TextEditingController();
  final phoneNumber = TextEditingController();
  final street = TextEditingController();


  final postalCode = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final country = TextEditingController();

  /// Location & Type Controllers
  final latitude = TextEditingController();
  final longitude = TextEditingController();
  final selectedAddressType = 'Home'.obs;
  @override
  void onInit() {
    super.onInit();
    getCurrentLocation();
    getAllAddresses();
    loadInitialUserAddress();
  }
  final GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();

  /// Fetch all addresses from Firebase
  Future<List<AddressModel>> getAllAddresses() async {
    try {
      List<AddressModel> addresses = await _repository.fetchUserAddresses();

      // 🔥 FIX 3: Agar array khali hai, toh variable ko khaali set karo taaki purana na dikhe
      if (addresses.isEmpty) {
        selectedAddress.value = AddressModel.empty();
        return [];
      }

      // 🔥 FIX 4: Agar by-chance kisi address mein 'selectedAddress = true' nahi hai,
      // toh automatically list ka pehla address select kar lo taaki hamesha address dikhe.
      selectedAddress.value = addresses.firstWhere(
            (element) => element.selectedAddress,
        orElse: () => addresses.first,
      );

      return addresses;
    } catch (e) {
      // Error aane par bhi variable khali karo
      selectedAddress.value = AddressModel.empty();
      return [];
    }
  }

  /// Update Coordinates from Map Tap or GPS
  void updateCoordinates(LatLng position) {
    latitude.text = position.latitude.toString();
    longitude.text = position.longitude.toString();
    update();
  }

  /// Fetch Current GPS Location
  Future<void> getCurrentLocation() async {
    try {
      // 🔥 FIX: Yahan se UFullScreenLoader hata diya taaki app crash na ho
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
        Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        LatLng currentLocation = LatLng(position.latitude, position.longitude);

        updateCoordinates(currentLocation);

        if (googleMapController != null) {
          googleMapController!.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(target: currentLocation, zoom: 16),
            ),
          );
        }
      }
    } catch (e) {
      UFullScreenLoader.stopLoading();
      USnackBarHelpers.errorSnackBar(title: 'Location Error', message: e.toString());
    }
  }

  /// Save New Address
  Future<void> addNewAddress() async {
    try {
      UFullScreenLoader.openLoadingDialog('Storing Address...');

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        UFullScreenLoader.stopLoading();
        return;
      }

      if (!addressFormKey.currentState!.validate()) {
        UFullScreenLoader.stopLoading();
        return;
      }

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
        latitude: double.tryParse(latitude.text.trim()) ?? 0.0,
        longitude: double.tryParse(longitude.text.trim()) ?? 0.0,
        addressType: selectedAddressType.value,
      );

      String addressId = await _repository.addAddress(address);
      address.id = addressId;
      await selectAddress(address);

      UFullScreenLoader.stopLoading();
      resetFormFields();
      // Navigator.pop(Get.context!);
      // Navigator.pop(Get.context!);
      Get.back();
      USnackBarHelpers.successSnackBar(title: 'Success', message: 'Address saved successfully');
      refreshData.toggle();
    } catch (e) {
      UFullScreenLoader.stopLoading();
      USnackBarHelpers.errorSnackBar(title: 'Error', message: e.toString());
    }
  }

  /// Select a specific address and update in DB
  Future<void> selectAddress(AddressModel newSelectedAddress) async {
    try {
      Get.defaultDialog(
        title: '',
        onWillPop: () async => false,
        barrierDismissible: false,
        backgroundColor: Colors.transparent,
        content: const UCircularLoader(),
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

  /// [FIX] Missing Method for Checkout Address Change
  // Future<void> selectNewAddressBottomSheet(BuildContext context) {
  //   return showModalBottomSheet(
  //     context: context,
  //     builder: (context) => SingleChildScrollView(
  //       child: Container(
  //         padding: const EdgeInsets.all(USizes.lg),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             USectionHeading(title: 'Select Address', showActionButtton: false),
  //             const SizedBox(height: USizes.spaceBtwItems),
  //             FutureBuilder(
  //               future: getAllAddresses(),
  //               builder: (context, snapshot) {
  //                 final widget = UCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot);
  //                 if (widget != null) return widget;
  //
  //                 return ListView.separated(
  //                   physics: const NeverScrollableScrollPhysics(),
  //                   shrinkWrap: true,
  //                   itemCount: snapshot.data!.length,
  //                   separatorBuilder: (_, __) => const SizedBox(height: USizes.spaceBtwItems),
  //                   itemBuilder: (context, index) => USingleAddress(
  //                     addresses: snapshot.data![index],
  //                     onTap: () async {
  //                       await selectAddress(snapshot.data![index]);
  //                       Get.back();
  //                     },
  //                   ),
  //                 );
  //               },
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  void resetFormFields() {
    name.clear();
    phoneNumber.clear();
    street.clear();
    postalCode.clear();
    city.clear();
    state.clear();
    country.clear();
    latitude.clear();
    longitude.clear();
    selectedAddressType.value = 'Home';
    addressFormKey.currentState?.reset();
    update();
  }
// Controller ke andar is method ko sahi kijiye
  void onCameraMove(CameraPosition position) {
    latitude.text = position.target.latitude.toString();
    longitude.text = position.target.longitude.toString();
    update();
  }

  /// --- EDIT ADDRESS LOGIC ---

  // 1. Jab bhi Edit button dabega, pehle purana data fields mein bhar do
  void initAddressData(AddressModel address) {
    name.text = address.name;
    phoneNumber.text = address.phoneNumber;
    street.text = address.street;
    postalCode.text = address.postalCode;
    city.text = address.city;
    state.text = address.state;
    country.text = address.country;
    latitude.text = address.latitude.toString();
    longitude.text = address.longitude.toString();
    selectedAddressType.value = address.addressType.isNotEmpty ? address.addressType : 'Home';
    update();
  }

  // 2. Naya data save karne ke liye
  Future<void> updateExistingAddress(String addressId, bool isSelected) async {
    try {
      UFullScreenLoader.openLoadingDialog('Updating Address...');

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        UFullScreenLoader.stopLoading();
        return;
      }

      if (!addressFormKey.currentState!.validate()) {
        UFullScreenLoader.stopLoading();
        return;
      }

      // Naya updated address model banao
      AddressModel updatedAddress = AddressModel(
        id: addressId,
        name: name.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        street: street.text.trim(),
        city: city.text.trim(),
        state: state.text.trim(),
        postalCode: postalCode.text.trim(),
        country: country.text.trim(),
        selectedAddress: isSelected, // Purana selection status maintain rakho
        dateTime: DateTime.now(),
        latitude: double.tryParse(latitude.text.trim()) ?? 0.0,
        longitude: double.tryParse(longitude.text.trim()) ?? 0.0,
        addressType: selectedAddressType.value,
      );

      // Firebase me update call karo
      // NOTE: Apne AddressRepository mein updateAddress(AddressModel address) function bana lena agar nahi hai toh
      await _repository.updateAddress(updatedAddress);

      // Agar yehi selected address tha, toh local state bhi update kar do
      if(selectedAddress.value.id == addressId){
        selectedAddress.value = updatedAddress;
      }

      UFullScreenLoader.stopLoading();
      resetFormFields();
      Navigator.pop(Get.context!); // Edit screen band karo
      USnackBarHelpers.successSnackBar(title: 'Success', message: 'Address updated successfully');
      refreshData.toggle(); // List ko refresh karo
    } catch (e) {
      UFullScreenLoader.stopLoading();
      USnackBarHelpers.errorSnackBar(title: 'Error', message: e.toString());
    }
  }
  /// 🔥 UPDATED: Bottom Sheet (Dark/Light mode support & Add New Address Button)
  /// 🔥 UPDATED: selectNewAddressBottomSheet
  Future<void> selectNewAddressBottomSheet(BuildContext context) {
    // 🔥 FIX 2B: Get.bottomSheet theme change par automatically react karta hai
    return Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(USizes.lg),
        // Ye line ensure karegi ki dark/light mode instantly change ho
        color: Theme.of(context).scaffoldBackgroundColor,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const USectionHeading(title: 'Select Delivery Address', showActionButtton: false),
              const SizedBox(height: USizes.spaceBtwItems),

              FutureBuilder(
                future: getAllAddresses(),
                builder: (context, snapshot) {
                  // 🔥 FIX 3: Custom Loading Animation jab tak data fetch ho raha ho
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Apna lottie file ka path check kar lena yahan
                          Lottie.asset('assets/animations/loading.json', width: 100, height: 100),
                          const SizedBox(height: 10),
                          Text('Loading addresses...', style: Theme.of(context).textTheme.bodyMedium),
                        ],
                      ),
                    );
                  }

                  // Agar data null hai ya list empty hai tab dikhayega "No address found"
                  if (!snapshot.hasData || snapshot.data == null || snapshot.data!.isEmpty) {
                    return const UEmptyStateWidget(
                      icon: Iconsax.location_add,
                      title: "No Saved Addresses Found 📍",
                      subTitle: "Tap the button below to add your first delivery address!",
                    );
                  }

                  // Data milne par List dikhayega
                  return ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    separatorBuilder: (_, __) => const SizedBox(height: USizes.spaceBtwItems),
                    itemBuilder: (context, index) => USingleAddress(
                      addresses: snapshot.data![index],
                      onTap: () async {
                        await selectAddress(snapshot.data![index]);
                        Get.back(); // Select hone par bottom sheet band kardo
                      },
                    ),
                  );
                },
              ),
              const SizedBox(height: USizes.spaceBtwSections),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.back(); // Pehle bottom sheet close karo
                    Get.to(() => const AddNewAddressScreen()); // Fir add screen pe jao
                  },
                  child: const Text('Add New Address'),
                ),
              ),
            ],
          ),
        ),
      ),
      isScrollControlled: true, // Lamba content handle karne ke liye
    );
  }

  // 🔥 FIX: Auto Bottom Sheet & Initial Load ke liye
  Future<void> loadInitialUserAddress() async {
    // 1. Agar user logged-in nahi hai, toh yahin se wapas mud jao (No Bottom Sheet on Login Page!)
    if (FirebaseAuth.instance.currentUser == null) {
      print("🔒 User logged out hai. Bottom sheet nahi khulegi.");
      return;
    }

    final addresses = await getAllAddresses();

    // 2. Agar address list khali hai aur user login hai
    if (addresses.isEmpty) {
      Future.delayed(const Duration(milliseconds: 500), () {
        // Double check ki tab tak user ne logout toh nahi kar diya ya login page pe toh nahi hai
        if (FirebaseAuth.instance.currentUser != null && Get.overlayContext != null) {
          // Check ki kya hum Navigation screen ya Home par hain
          if (Get.currentRoute != '/LoginScreen' && Get.currentRoute != '/OnboardingScreen') {
            print("📍 Naya user detected! Opening Address Bottom Sheet...");
            selectNewAddressBottomSheet(Get.overlayContext!);
          }
        }
      });
    }
  }

}