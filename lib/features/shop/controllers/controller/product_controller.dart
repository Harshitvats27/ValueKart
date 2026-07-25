// import 'package:e_commerce_application/utils/constants/enums.dart';
// import 'package:e_commerce_application/utils/pop_ups/snackbar_helpers.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_state_manager/src/simple/get_controllers.dart';
//
// import '../../../../Store/store_repository.dart';
// import '../../../../data/repositories/product_repository.dart';
// import '../../../personalisation/controllers/address_controller.dart';
// import '../../models/product_model.dart';
// import '../../models/product_variation_model.dart';
//
// class ProductController extends GetxController {
//   static ProductController get instance => Get.find();
//   Rx<ProductVariationModel?> selectedVariation = Rx<ProductVariationModel?>(null);
//   RxMap<String, dynamic> selectedAttributes = <String, dynamic>{}.obs;
//   RxList<ProductModel> featuredProducts = <ProductModel>[].obs;
//   RxBool isLoading = false.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     // Delay laga diya taaki pehle Address aa jaye, phir products aayein
//     Future.delayed(const Duration(milliseconds: 300), () {
//       getFeaturedProducts();
//     });
//   }
//
//   final _productRepository = Get.put(ProductRepository());
//   void onAttributeSelected(ProductModel product, String attributeName, String attributeValue) {
//     // 1. Map mein selected value daal
//     selectedAttributes[attributeName] = attributeValue;
//
//     // 2. Matching variation dhoondho
//     ProductVariationModel? matchingVariation;
//
//     if (product.productVariations != null && product.productVariations!.isNotEmpty) {
//       for (var variation in product.productVariations!) {
//         bool isMatch = true;
//
//         variation.attributeValues.forEach((key, value) {
//           if (selectedAttributes[key] != value) {
//             isMatch = false;
//           }
//         });
//
//         if (isMatch) {
//           matchingVariation = variation;
//           break; // Match milte hi loop rok do
//         }
//       }
//     }
//
//     // 3. UI ko update karne ke liye selectedVariation me daal do
//     selectedVariation.value = matchingVariation;
//   }
//   // Function to get only 4 featured products
//   // 🔥 FIX 2: Asli Hyperlocal Logic jo Home Screen UI update karega!
//   Future<void> getFeaturedProducts() async {
//     try {
//       isLoading.value = true;
//       print('\n========== 🚀 FETCHING HYPERLOCAL PRODUCTS FOR HOME SCREEN ==========');
//
//       // 1. Address nikalte hain
//       final addressController = Get.put(AddressController());
//       final selectedAddress = addressController.selectedAddress.value;
//
//       // Agar address nahi hai
//       if (selectedAddress.id.isEmpty || selectedAddress.latitude == 0.0) {
//         print('❌ No address found. UI ko empty products bhejenge.');
//         featuredProducts.assignAll([]); // List khali kardo
//         return;
//       }
//
//       // 2. Stores mangwao
//       final storeRepo = Get.put(StoreRepository());
//       final allStores = await storeRepo.fetchAllActiveStores();
//
//       // 3. 10 KM wale Stores nikalo
//       List<String> serviceableStoreIds = [];
//       for (var store in allStores) {
//         double distanceInMeters = Geolocator.distanceBetween(
//           selectedAddress.latitude,
//           selectedAddress.longitude,
//           store.latitude,
//           store.longitude,
//         );
//
//         double distanceInKm = distanceInMeters / 1000;
//
//         // Agar distance vendor ke radius mein hai
//         if (distanceInKm <= store.deliveryRadius) {
//           serviceableStoreIds.add(store.id);
//         }
//       }
//
//       print('🎯 Serviceable Stores Found: ${serviceableStoreIds.length}');
//
//       if (serviceableStoreIds.isEmpty) {
//         featuredProducts.assignAll([]); // Koi store paas nahi hai
//         return;
//       }
//
//       // 4. Products fetch karo
//       List<ProductModel> allFeatured = await _productRepository.fetchFeaturedProducts();
//
//       // 5. Products ko filter maaro
//       List<ProductModel> nearbyProducts = allFeatured.where((product) {
//         if (product.storeId == null || product.storeId!.isEmpty) return false;
//         return serviceableStoreIds.contains(product.storeId);
//       }).toList();
//
//       print('🎉 Final Products for UI: ${nearbyProducts.length}');
//
//       // 🔥 JADU: Yahan UI update hoga!
//       featuredProducts.assignAll(nearbyProducts);
//
//     } catch (e) {
//       print('🚨 CRITICAL ERROR: $e');
//       USnackBarHelpers.errorSnackBar(title: 'Failed', message: e.toString());
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   // Function to get products
//
//   //ye phle wala h original
//   // Future<List<ProductModel>> getAllFeaturedProducts() async {
//   //   try {
//   //
//   //
//   //     // fetch featured products
//   //     List<ProductModel> featuredProducts = await _productRepository
//   //         .fetchAllFeaturedProducts();
//   //   return featuredProducts;
//   //   } catch (e) {
//   //     USnackBarHelpers.errorSnackBar(title: 'Failed', message: e.toString());
//   //     return [];
//   //   }
//   // }
//
//   // 🔥 UPDATED: Naya Hyperlocal logic
//   // Future<List<ProductModel>> getAllFeaturedProducts() async {
//   //   try {
//   //     final addressController = Get.put(AddressController());
//   //     final selectedAddress = addressController.selectedAddress.value;
//   //
//   //     // 1. Check if user has selected an address
//   //     if (selectedAddress.id.isEmpty || selectedAddress.latitude == 0.0) {
//   //       // Address select nahi kiya hai toh UI pe kuch nahi dikhega
//   //       return [];
//   //     }
//   //
//   //     // 2. Fetch all active stores from Database
//   //     final storeRepo = Get.put(StoreRepository());
//   //     final allStores = await storeRepo.fetchAllActiveStores();
//   //
//   //     // 3. Find serviceable stores within the radius
//   //     List<String> serviceableStoreIds = [];
//   //
//   //     for (var store in allStores) {
//   //       // Distance in meters
//   //       double distanceInMeters = Geolocator.distanceBetween(
//   //         selectedAddress.latitude,
//   //         selectedAddress.longitude,
//   //         store.latitude,
//   //         store.longitude,
//   //       );
//   //
//   //       double distanceInKm = distanceInMeters / 1000;
//   //
//   //       // Agar distance store ke radius (e.g. 10km) se kam ya barabar hai
//   //       if (distanceInKm <= store.deliveryRadius) {
//   //         serviceableStoreIds.add(store.id);
//   //       }
//   //     }
//   //
//   //     // 4. Agar koi store aas paas nahi hai
//   //     if (serviceableStoreIds.isEmpty) {
//   //       return []; // Empty list return karenge
//   //     }
//   //
//   //     // 5. Fetch ALL featured products
//   //     List<ProductModel> allFeatured = await _productRepository.fetchAllFeaturedProducts();
//   //
//   //     // 6. Filter products locally based on serviceableStoreIds
//   //     List<ProductModel> nearbyProducts = allFeatured.where((product) {
//   //       return serviceableStoreIds.contains(product.storeId);
//   //     }).toList();
//   //
//   //     return nearbyProducts;
//   //
//   //   } catch (e) {
//   //     USnackBarHelpers.errorSnackBar(title: 'Failed', message: e.toString());
//   //     return [];
//   //   }
//   // }
//
// // 🔥 HEAVY DEBUGGING WALA HYPERLOCAL LOGIC
//   Future<List<ProductModel>> getAllFeaturedProducts() async {
//     try {
//       print('\n\n========== 🚀 STARTING HYPERLOCAL FETCH ==========');
//       final addressController = Get.put(AddressController());
//       final selectedAddress = addressController.selectedAddress.value;
//
//       print('📍 1. Selected Address ID: ${selectedAddress.id}');
//       print('   -> Lat: ${selectedAddress.latitude}, Lng: ${selectedAddress.longitude}');
//
//       // 1. Check if user has selected an address
//       if (selectedAddress.id.isEmpty || selectedAddress.latitude == 0.0) {
//         print('❌ Address is empty or Lat is 0.0. UI ko empty dikhayenge.');
//         return [];
//       }
//
//       // 2. Fetch all active stores from Database
//       final storeRepo = Get.put(StoreRepository());
//       final allStores = await storeRepo.fetchAllActiveStores();
//       print('🏪 2. Total Active Stores Fetched from DB: ${allStores.length}');
//
//       // 3. Find serviceable stores within the radius
//       List<String> serviceableStoreIds = [];
//
//       for (var store in allStores) {
//         double distanceInMeters = Geolocator.distanceBetween(
//           selectedAddress.latitude,
//           selectedAddress.longitude,
//           store.latitude,
//           store.longitude,
//         );
//
//         double distanceInKm = distanceInMeters / 1000;
//
//         print('\n   🔎 Checking Store: ${store.storeName} (ID: ${store.id})');
//         print('      -> Store Lat: ${store.latitude}, Lng: ${store.longitude}');
//         print('      -> Distance from User: ${distanceInKm.toStringAsFixed(2)} KM');
//         print('      -> Store Delivery Radius: ${store.deliveryRadius} KM');
//
//         if (distanceInKm <= store.deliveryRadius) {
//           print('      ✅ MATCH! Store is IN RANGE.');
//           serviceableStoreIds.add(store.id);
//         } else {
//           print('      ❌ REJECTED! Store is OUT OF RANGE.');
//         }
//       }
//
//       print('\n🎯 3. Total Serviceable Stores Found: ${serviceableStoreIds.length}');
//       print('   -> IDs: $serviceableStoreIds');
//
//       if (serviceableStoreIds.isEmpty) {
//         print('❌ No serviceable stores near user. Returning empty list.');
//         return [];
//       }
//
//       // 5. Fetch ALL featured products
//       List<ProductModel> allFeatured = await _productRepository.fetchAllFeaturedProducts();
//       print('\n📦 4. Total Featured Products Fetched from DB: ${allFeatured.length}');
//
//       // 6. Filter products locally
//       print('\n⚖️ 5. FILTERING PRODUCTS:');
//       List<ProductModel> nearbyProducts = allFeatured.where((product) {
//
//         // Purane products jisme storeId null hai unko pakadte hain
//         if (product.storeId == null || product.storeId!.isEmpty) {
//           print('   ⚠️ WARNING: Product "${product.title}" has NO storeId! (Old Data?) -> Skipping.');
//           return false;
//         }
//
//         bool isMatch = serviceableStoreIds.contains(product.storeId);
//
//         if (isMatch) {
//           print('   ✅ ADDED: "${product.title}" (Matches Store: ${product.storeId})');
//         } else {
//           print('   ❌ REJECTED: "${product.title}" (Store ${product.storeId} not in range)');
//         }
//
//         return isMatch;
//       }).toList();
//
//       print('\n🎉 6. FINAL PRODUCTS TO SHOW ON HOME SCREEN: ${nearbyProducts.length}');
//       print('========== 🏁 END HYPERLOCAL FETCH ==========\n\n');
//
//       return nearbyProducts;
//
//     } catch (e) {
//       print('🚨🚨🚨 CRITICAL ERROR IN getAllFeaturedProducts: $e');
//       USnackBarHelpers.errorSnackBar(title: 'Failed', message: e.toString());
//       return [];
//     }
//   }
//
//
//   // calculate Sale Precentge
//   String? calculateSalePercentage(double originalPrice, double? salePrice) {
//     if (salePrice == null || salePrice <= 0.0) {
//       return null;
//     }
//     if (originalPrice <= 0.0) {
//       return null;
//     }
//     double percentage = ((originalPrice - salePrice) / originalPrice) * 100; return '${percentage.toStringAsFixed(1)}';
//   }
//
//   // String getProductprices(ProductModel product){
//   //   double smallestPrice=double.infinity;
//   //   double largestPrice=0.0;
//   //
//   //   if(product.productType==ProductType.single.toString()){
//   //     return product.salePrice>0?product.salePrice.toString():product.price.toString();
//   //   }
//   //   if(product.price<smallestPrice){
//   //     smallestPrice=product.price;
//   //   }else {
//   //     for (final variation in product.productVariations!) {
//   //       double variationPrice = variation.salePrice > 0
//   //           ? variation.salePrice
//   //           : variation.price;
//   //       if (variationPrice < smallestPrice) {
//   //         smallestPrice = variationPrice;
//   //       }
//   //       if (variationPrice > largestPrice) {
//   //         largestPrice = variationPrice;
//   //       }
//   //     }
//   //
//   //     if (smallestPrice.isEqual(largestPrice)) {
//   //       return largestPrice.toString();
//   //     } else {
//   //       return '${largestPrice.toStringAsFixed(0)} - ${smallestPrice
//   //           .toStringAsFixed(0)}';
//   //     }
//   //   }
//   //
//   // }
//   String getProductPrices(ProductModel product) {
//
//     final variation = selectedVariation.value;
//
//     // 🔥 DEBUG START
//     print("========== PRICE DEBUG ==========");
//     print("Product Type: ${product.productType}");
//     print("Selected Variation: $variation");
//
//     // ✅ IF VARIATION SELECTED
//     if (variation != null) {
//       final price = variation.salePrice > 0
//           ? variation.salePrice
//           : variation.price;
//
//       print("👉 USING VARIATION PRICE: $price");
//       print("================================");
//
//       return price.toStringAsFixed(0);
//     }
//
//     // ✅ SINGLE PRODUCT
//     if (product.productType == ProductType.single.toString()) {
//       final price = product.salePrice > 0
//           ? product.salePrice
//           : product.price;
//
//       print("👉 USING SINGLE PRODUCT PRICE: $price");
//       print("================================");
//
//       return price.toStringAsFixed(0);
//     }
//
//     // ✅ VARIABLE PRODUCT RANGE
//     double smallestPrice = double.infinity;
//     double largestPrice = 0.0;
//
//     if (product.productVariations == null ||
//         product.productVariations!.isEmpty) {
//
//       print("❌ NO VARIATIONS FOUND");
//       print("================================");
//
//       return product.price.toStringAsFixed(0);
//     }
//
//     for (final v in product.productVariations!) {
//
//       final variationPrice = v.salePrice > 0
//           ? v.salePrice
//           : v.price;
//
//       print("Loop Variation Price: $variationPrice");
//
//       if (variationPrice < smallestPrice) smallestPrice = variationPrice;
//       if (variationPrice > largestPrice) largestPrice = variationPrice;
//     }
//
//     print("👉 RANGE: $smallestPrice - $largestPrice");
//     print("================================");
//
//     if (smallestPrice == largestPrice) {
//       return largestPrice.toStringAsFixed(0);
//     }
//
//     return '${smallestPrice.toStringAsFixed(0)} - ${largestPrice.toStringAsFixed(0)}';
//   }
//
//   String getProductStockStatus(int stock){
//     return stock>0?'In Stock':'Out of Stock';
//   }
//
//   Future<List<ProductModel>> getAllProducts()async{
//     try{
//       List<ProductModel> products = await _productRepository.fetchAllProducts();
//       return products;
//     }catch(e){
//       USnackBarHelpers.errorSnackBar(title: 'Error', message: e.toString());
//       return [];
//     }
//
//   }
//
// }
//
//
import 'package:e_commerce_application/utils/constants/enums.dart';
import 'package:e_commerce_application/utils/pop_ups/snackbar_helpers.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import '../../../../Store/store_repository.dart';
import '../../../../data/repositories/product_repository.dart';
import '../../../personalisation/controllers/address_controller.dart';
import '../../models/product_model.dart';
import '../../models/product_variation_model.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();
  Rx<ProductVariationModel?> selectedVariation = Rx<ProductVariationModel?>(null);
  RxMap<String, dynamic> selectedAttributes = <String, dynamic>{}.obs;
  RxList<ProductModel> featuredProducts = <ProductModel>[].obs;
  RxBool isLoading = false.obs;

  final _productRepository = Get.put(ProductRepository());

  @override
  void onInit() {
    super.onInit();

    // 🔥 REACTIVE MAGIC: Jaise hi Address badlega, ye automatically products wapas fetch karega!
    final addressController = Get.put(AddressController());
    ever(addressController.selectedAddress, (_) {
      print("📍 Address changed! Refreshing products...");
      getFeaturedProducts();
    });

    // Initial load ke liye thoda delay
    Future.delayed(const Duration(milliseconds: 300), () {
      getFeaturedProducts();
    });
  }

  // 🔥 1. Helper Function: 10 KM Radius wale Stores nikalne ke liye
  Future<List<String>> _getServiceableStoreIds() async {
    final addressController = Get.put(AddressController());
    final selectedAddress = addressController.selectedAddress.value;

    // Agar address khali hai ya lat 0 hai, toh empty return karo
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
      if (distanceInKm <= store.deliveryRadius) {
        serviceableStoreIds.add(store.id);
      }
    }
    return serviceableStoreIds;
  }

  // 🔥 2. Home Screen ke Featured Products (With 10 KM Filter)
  Future<void> getFeaturedProducts() async {
    try {
      isLoading.value = true;
      final serviceableStoreIds = await _getServiceableStoreIds();

      // Agar aas-paas koi store nahi hai ya address nahi hai -> List KHALI KARDO
      if (serviceableStoreIds.isEmpty) {
        featuredProducts.assignAll([]);
        return;
      }

      List<ProductModel> allFeatured = await _productRepository.fetchFeaturedProducts();
      List<ProductModel> nearbyProducts = allFeatured.where((product) {
        if (product.storeId == null || product.storeId!.isEmpty) return false;
        return serviceableStoreIds.contains(product.storeId);
      }).toList();

      featuredProducts.assignAll(nearbyProducts);
    } catch (e) {
      USnackBarHelpers.errorSnackBar(title: 'Failed', message: e.toString());
      featuredProducts.assignAll([]);
    } finally {
      isLoading.value = false;
    }
  }

  // 🔥 3. "See All" Screen ke liye Featured Products (With 10 KM Filter)
  Future<List<ProductModel>> getAllFeaturedProducts() async {
    try {
      final serviceableStoreIds = await _getServiceableStoreIds();
      if (serviceableStoreIds.isEmpty) return [];

      List<ProductModel> allFeatured = await _productRepository.fetchAllFeaturedProducts();
      return allFeatured.where((product) {
        if (product.storeId == null || product.storeId!.isEmpty) return false;
        return serviceableStoreIds.contains(product.storeId);
      }).toList();
    } catch (e) {
      USnackBarHelpers.errorSnackBar(title: 'Failed', message: e.toString());
      return [];
    }
  }

  // 🔥 4. All Products Screen / Store Tab ke liye (With 10 KM Filter)
  Future<List<ProductModel>> getAllProducts() async {
    try {
      final serviceableStoreIds = await _getServiceableStoreIds();
      if (serviceableStoreIds.isEmpty) return [];

      List<ProductModel> products = await _productRepository.fetchAllProducts();
      return products.where((product) {
        if (product.storeId == null || product.storeId!.isEmpty) return false;
        return serviceableStoreIds.contains(product.storeId);
      }).toList();
    } catch (e) {
      USnackBarHelpers.errorSnackBar(title: 'Error', message: e.toString());
      return [];
    }
  }

  // Tere baki ke puraane variation aur price calculate karne wale functions...
  void onAttributeSelected(ProductModel product, String attributeName, String attributeValue) {
    selectedAttributes[attributeName] = attributeValue;
    ProductVariationModel? matchingVariation;
    if (product.productVariations != null && product.productVariations!.isNotEmpty) {
      for (var variation in product.productVariations!) {
        bool isMatch = true;
        variation.attributeValues.forEach((key, value) {
          if (selectedAttributes[key] != value) isMatch = false;
        });
        if (isMatch) {
          matchingVariation = variation;
          break;
        }
      }
    }
    selectedVariation.value = matchingVariation;
  }

  String? calculateSalePercentage(double originalPrice, double? salePrice) {
    if (salePrice == null || salePrice <= 0.0 || originalPrice <= 0.0) return null;
    double percentage = ((originalPrice - salePrice) / originalPrice) * 100;
    return percentage.toStringAsFixed(1);
  }

  String getProductPrices(ProductModel product) {
    final variation = selectedVariation.value;
    if (variation != null) {
      return (variation.salePrice > 0 ? variation.salePrice : variation.price).toStringAsFixed(0);
    }
    if (product.productType == ProductType.single.toString()) {
      return (product.salePrice > 0 ? product.salePrice : product.price).toStringAsFixed(0);
    }
    if (product.productVariations == null || product.productVariations!.isEmpty) {
      return product.price.toStringAsFixed(0);
    }
    double smallestPrice = double.infinity;
    double largestPrice = 0.0;
    for (final v in product.productVariations!) {
      final variationPrice = v.salePrice > 0 ? v.salePrice : v.price;
      if (variationPrice < smallestPrice) smallestPrice = variationPrice;
      if (variationPrice > largestPrice) largestPrice = variationPrice;
    }
    if (smallestPrice == largestPrice) return largestPrice.toStringAsFixed(0);
    return '${smallestPrice.toStringAsFixed(0)} - ${largestPrice.toStringAsFixed(0)}';
  }

  String getProductStockStatus(int stock) {
    return stock > 0 ? 'In Stock' : 'Out of Stock';
  }
}