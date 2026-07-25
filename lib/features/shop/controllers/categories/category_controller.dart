// import 'package:e_commerce_application/data/repositories/product_repository.dart';
// import 'package:e_commerce_application/utils/pop_ups/snackbar_helpers.dart';
// import 'package:get/get.dart';
// import 'package:get/get_rx/src/rx_types/rx_types.dart';
// import 'package:get/get_state_manager/src/simple/get_controllers.dart';
// import '../../../../data/repositories/category/category_repository.dart';
// import '../../models/category_model.dart';
// import '../../models/product_model.dart';
//
// class CategoryController extends GetxController {
//   static CategoryController get instance => Get.find();
//   final _repository = Get.put(CategoryRepository());
//   final RxList<CategoryModel> categories = <CategoryModel>[].obs;
//   RxList<CategoryModel> featuredCategories = <CategoryModel>[].obs;
//   final RxBool isLoading = false.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchCategories();
//   }
//
//   // Future<void> fetchCategories() async {
//   //   try {
//   //     isLoading.value = true;
//   //     final data = await CategoryRepository.instance.fetchCategories();
//   //     categories.assignAll(data);
//   //   } catch (e) {
//   //     // optional snackbar
//   //   } finally {
//   //     isLoading.value = false;
//   //   }
//   // }
//   Future<void> fetchCategories() async {
//     try {
//       isLoading.value = true;
//       List<CategoryModel> data = await CategoryRepository.instance
//           .fetchCategories();
//       categories.assignAll(data);
//       featuredCategories.assignAll(
//         data.where(
//           (element) => element.isFeatured == true && element.parentId.isEmpty,
//         ),
//       );
//     } catch (e) {
//       print("🔥 ASLI ERROR YAHAN HAI: $e");
//       USnackBarHelpers.errorSnackBar(title: 'Error', message: e.toString());
//     }finally {isLoading.value = false;}
//   }
//
//   Future<List<ProductModel>> getCategoryProducts({required String categoryId,int limit=4}) async {
//
//     try{
//       final products =ProductRepository.instance.getProductsForCategory(categoryId: categoryId,limit: limit);
//       return products;
//     }catch(e){
//       USnackBarHelpers.errorSnackBar(title: 'Error', message: e.toString());
//       return [];
//     }
//
//   }
//
//
//   Future<List<CategoryModel>> getSubCategories(String categoryId)async{
//
//
//     try{
//       final subCategories =await _repository.getSubCategories(categoryId);
//       return subCategories;
//     }catch(e){
//       USnackBarHelpers.errorSnackBar(title: 'Error', message: e.toString());
//       return [];
//     }
//   }
//
//
// }
import 'package:e_commerce_application/data/repositories/product_repository.dart';
import 'package:e_commerce_application/utils/pop_ups/snackbar_helpers.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart'; // 🔥 ADDED: Geolocator import kiya distance ke liye

import '../../../../Store/store_repository.dart';
import '../../../../data/repositories/category/category_repository.dart';
import '../../../personalisation/controllers/address_controller.dart'; // 🔥 ADDED: Address Controller import kiya
import '../../models/category_model.dart';
import '../../models/product_model.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();
  final _repository = Get.put(CategoryRepository());
  final RxList<CategoryModel> categories = <CategoryModel>[].obs;
  RxList<CategoryModel> featuredCategories = <CategoryModel>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      isLoading.value = true;
      List<CategoryModel> data = await CategoryRepository.instance.fetchCategories();
      categories.assignAll(data);
      featuredCategories.assignAll(
        data.where(
              (element) => element.isFeatured == true && element.parentId.isEmpty,
        ),
      );
    } catch (e) {
      print("🔥 ASLI ERROR YAHAN HAI: $e");
      USnackBarHelpers.errorSnackBar(title: 'Error', message: e.toString());
    } finally {
      isLoading.value = false;
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

  // 🔥 2. UPDATED: Category Products with 10 KM Hyperlocal Filter
  Future<List<ProductModel>> getCategoryProducts({required String categoryId, int limit = 4}) async {
    try {
      // Pehle 10 KM wale stores ki ID mangwao
      final serviceableStoreIds = await _getServiceableStoreIds();

      // Agar aas-paas koi store nahi hai -> Empty list return karo (UI dikhayega: No products available)
      if (serviceableStoreIds.isEmpty) {
        return [];
      }

      // Repository se us category ke products fetch karo
      final products = await ProductRepository.instance.getProductsForCategory(
        categoryId: categoryId,
        limit: limit,
      );

      // 🔥 LOCAL FILTERING: Sirf unhi products ko rakhnge jinka storeId humare 10 KM wale radius mein hai
      final nearbyProducts = products.where((product) {
        if (product.storeId == null || product.storeId!.isEmpty) return false;
        return serviceableStoreIds.contains(product.storeId);
      }).toList();

      return nearbyProducts;
    } catch (e) {
      USnackBarHelpers.errorSnackBar(title: 'Error', message: e.toString());
      return [];
    }
  }

  Future<List<CategoryModel>> getSubCategories(String categoryId) async {
    try {
      final subCategories = await _repository.getSubCategories(categoryId);
      return subCategories;
    } catch (e) {
      USnackBarHelpers.errorSnackBar(title: 'Error', message: e.toString());
      return [];
    }
  }
}