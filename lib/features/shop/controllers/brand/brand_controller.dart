// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:e_commerce_application/data/repositories/product_repository.dart';
// import 'package:e_commerce_application/features/shop/models/product_model.dart';
// import 'package:e_commerce_application/utils/pop_ups/snackbar_helpers.dart';
// import 'package:get/get.dart';
//
// import '../../../../data/repositories/brand/brand_repository.dart';
// import '../../models/brand_model.dart';
//
// class BrandController extends GetxController {
//   static BrandController get instance => Get.find();
//
//   final _db = FirebaseFirestore.instance;
//   final _repository = Get.put(BrandRepository());
//   RxList<BrandModel> allBrands = <BrandModel>[].obs;
//   RxList<BrandModel> featuredBrands = <BrandModel>[].obs;
//   RxBool isLoading = false.obs;
//
//   @override
//   void onInit() {
//     getBrands();
//     super.onInit();
//   }
//
//   Future<void> getBrands() async {
//     try {
//       isLoading(true);
//
//       List<BrandModel> allBrands = await _repository.fetchBrands();
//       this.allBrands.assignAll(allBrands);
//       this.featuredBrands.assignAll(
//         allBrands.where((brand) => brand.isFeatured ?? false).toList(),
//       );
//     } catch (e) {
//       USnackBarHelpers.errorSnackBar(title: 'Failed', message: e.toString());
//     } finally {
//       isLoading(false);
//     }
//   }
//
//   // get Brand Specific Products
//   Future<List<ProductModel>> getBrandProducts(String brandId,{int limit=-1}) async {
//     try {
//       List<ProductModel> products = await ProductRepository.instance
//           .getProductsForBrand(brandId: brandId,limit: limit);
//       return products;
//     } catch (e) {
//       USnackBarHelpers.errorSnackBar(title: 'Failed', message: e.toString());
//       return [];
//     }
//   }
//
//   // Get Brands for Specific Category
//
// Future<List<BrandModel>> getBrandsForCategory(String categoryId) async {
//
//     try{
//
//     final brands = await _repository.fetchBrandsForCategory(categoryId);
//     return brands;
//
//
//
//     }catch(e){
//       USnackBarHelpers.errorSnackBar(title: 'Failed', message: e.toString());
//       return [];
//     }
// }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_application/data/repositories/product_repository.dart';
import 'package:e_commerce_application/features/shop/models/product_model.dart';
import 'package:e_commerce_application/utils/pop_ups/snackbar_helpers.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart'; // 🔥 ADDED: Geolocator distance napne ke liye

import '../../../../Store/store_repository.dart';
import '../../../../data/repositories/brand/brand_repository.dart';
import '../../../personalisation/controllers/address_controller.dart'; // 🔥 ADDED: Address Controller
import '../../models/brand_model.dart';

class BrandController extends GetxController {
  static BrandController get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  final _repository = Get.put(BrandRepository());
  RxList<BrandModel> allBrands = <BrandModel>[].obs;
  RxList<BrandModel> featuredBrands = <BrandModel>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    getBrands();
    super.onInit();
  }

  Future<void> getBrands() async {
    try {
      isLoading(true);

      List<BrandModel> allBrands = await _repository.fetchBrands();
      this.allBrands.assignAll(allBrands);
      this.featuredBrands.assignAll(
        allBrands.where((brand) => brand.isFeatured ?? false).toList(),
      );
    } catch (e) {
      USnackBarHelpers.errorSnackBar(title: 'Failed', message: e.toString());
    } finally {
      isLoading(false);
    }
  }

  // 🔥 1. HELPER FUNCTION: 10 KM Radius wale Stores nikalne ke liye
  Future<List<String>> _getServiceableStoreIds() async {
    final addressController = Get.put(AddressController());
    final selectedAddress = addressController.selectedAddress.value;

    // Agar user ne address select nahi kiya ya latitude 0 hai
    if (selectedAddress.id.isEmpty || selectedAddress.latitude == 0.0) {
      return [];
    }

    final storeRepo = Get.put(StoreRepository());
    final allStores = await storeRepo.fetchAllActiveStores();
    List<String> serviceableStoreIds = [];

    for (var store in allStores) {
      double distanceInMeters = Geolocator.distanceBetween(
        selectedAddress.latitude,
        selectedAddress.longitude,
        store.latitude,
        store.longitude,
      );

      double distanceInKm = distanceInMeters / 1000;
      // Check ki kya distance vendor ke set kiye gaye radius (e.g., 10 KM) ke andar hai
      if (distanceInKm <= store.deliveryRadius) {
        serviceableStoreIds.add(store.id);
      }
    }
    return serviceableStoreIds;
  }

  // 🔥 2. UPDATED: Get Brand Specific Products with 10 KM Hyperlocal Filter
  Future<List<ProductModel>> getBrandProducts(String brandId, {int limit = -1}) async {
    try {
      // Pehle 10 KM radius wale stores mangwao
      final serviceableStoreIds = await _getServiceableStoreIds();

      // Agar aas-paas koi store nahi hai -> Empty list return karo
      if (serviceableStoreIds.isEmpty) {
        return [];
      }

      // Repository se us brand ke saare products fetch karo
      List<ProductModel> products = await ProductRepository.instance
          .getProductsForBrand(brandId: brandId, limit: limit);

      // 🔥 LOCAL FILTERING: Sirf unhi products ko rakhnge jinka storeId humare 10 KM wale radius mein hai
      final nearbyProducts = products.where((product) {
        if (product.storeId == null || product.storeId!.isEmpty) return false;
        return serviceableStoreIds.contains(product.storeId);
      }).toList();

      return nearbyProducts;
    } catch (e) {
      USnackBarHelpers.errorSnackBar(title: 'Failed', message: e.toString());
      return [];
    }
  }

  // Get Brands for Specific Category
  Future<List<BrandModel>> getBrandsForCategory(String categoryId) async {
    try {
      final brands = await _repository.fetchBrandsForCategory(categoryId);
      return brands;
    } catch (e) {
      USnackBarHelpers.errorSnackBar(title: 'Failed', message: e.toString());
      return [];
    }
  }
}