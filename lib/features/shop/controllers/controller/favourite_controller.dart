import 'dart:convert';

import 'package:e_commerce_application/common/data/repositories/authentication_repository.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../data/repositories/product_repository.dart';
import '../../../../utils/pop_ups/snackbar_helpers.dart';
import '../../models/product_model.dart';

class FavouriteController extends GetxController {
  static FavouriteController instance = Get.find();

  // variobles
  RxMap<String, bool> favourites = <String, bool>{}.obs;
  final _storage = GetStorage(AuthenticationReposiotory.instance.currentUser!.uid);


  @override
  void onInit() {
    initFavourites();
    super.onInit();
  }

  void toggleFavouriteProduct(String productId) {
    if (favourites.containsKey(productId)) {
      favourites.remove(productId);
      saveFavouritestoStorage();
      USnackBarHelpers.customToast(message: 'Product hs been removed from the Wishlist');
    } else {
      favourites[productId] = true;
    }
    saveFavouritestoStorage();
    USnackBarHelpers.customToast(message: 'Product hs been added to the Wishlist');

  }

  Future<void> initFavourites() async{
    String? encodedFavourites =await _storage.read('favourites');
    if (encodedFavourites == null) return;
    Map<String,dynamic> storedFavourites= jsonDecode(encodedFavourites)as Map<String,dynamic>;
    favourites.assignAll(storedFavourites.map((key, value) => MapEntry(key, value as bool)));



  }



  void saveFavouritestoStorage()  {
    String encodeFavourites=jsonEncode(favourites);
    _storage.write('favourites', encodeFavourites);

  }

  bool isFavourite(String productId) {
    return favourites[productId]??false;
  }

  // Future<List<ProductModel>> getFavouriteProducts() async {
  //   final productIds =favourites.keys.toList();
  //   print("Favourite IDs: $productIds");
  //   return await ProductRepository.instance.getFavouriteProducts(productIds);
  // }

  Future<List<ProductModel>> getFavouriteProducts() async {
    final productIds = favourites.keys.toList();

    print("Favourite IDs: $productIds");

    // ✅ Prevent empty query
    if (productIds.isEmpty) {
      return [];
    }

    return await ProductRepository.instance
        .getFavouriteProducts(productIds);
  }

}
