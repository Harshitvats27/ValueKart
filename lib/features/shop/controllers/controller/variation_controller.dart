import 'package:e_commerce_application/features/shop/controllers/controller/image_controller.dart';
import 'package:e_commerce_application/features/shop/models/product_model.dart';
import 'package:e_commerce_application/features/shop/models/product_variation_model.dart';
import 'package:get/get.dart';

class VariationController extends GetxController {
  static VariationController get instance => Get.find();

  RxMap selectedAttribute = {}.obs;
  Rx<ProductVariationModel> selectedVariation =
      ProductVariationModel.empty().obs;

  RxString variationStockStatus = ''.obs;

  // on attribute selected

  void onAttributeSelected(
    ProductModel product,
    attributeName,
    attributeValue,
  ) {
    Map<String, dynamic> selectedAttributes = Map<String, dynamic>.from(
      this.selectedAttribute,
    );
    selectedAttributes[attributeName] = attributeValue;
    this.selectedAttribute[attributeName] = attributeValue;
    ProductVariationModel selectedVariation = product.productVariations!
        .firstWhere(
          (variation) => isSameAttributeValue(
            variation.attributeValues,
            selectedAttributes,
          ),
          orElse: () => ProductVariationModel.empty(),
        );

    if (selectedVariation.image.isNotEmpty) {
      ImageController.instance.selectedProductImage.value =
          selectedVariation.image;
    }
    // Assiogn selected Variation in RX variable

    this.selectedVariation(selectedVariation);
    getProductVariationStockStatus(product);
  }

  bool isSameAttributeValue(
    Map<String, dynamic> variationAttribute,
    Map<String, dynamic> selectedAttributes,
  ) {
    // if selectedAttribute has 3 attributes and current variation has  attributes
    if (variationAttribute.length != selectedAttributes.length) return false;

    // if any of the attribute is different then return {green , large }!= {green,small}
    for (final key in variationAttribute.keys) {
      if (variationAttribute[key] != selectedAttributes[key]) {
        return false;
      }
    }
    return true;
  }

  Set<String?> getAttributesAvailabilityInVariation(
    List<ProductVariationModel> variations,
    String attributeName,
  ) {
    // pass the variation to check which attribute are available and stock is not 0
    final availableAttributesvalues = variations
        .where(
          (variation) =>
              variation.attributeValues[attributeName]!.isNotEmpty &&
              variation.attributeValues[attributeName] != null &&
              variation.stock > 0,
        )
        .map((variation) => variation.attributeValues[attributeName])
        .toSet();
    return availableAttributesvalues;
  }

  // check product variation stock status
  void getProductVariationStockStatus(ProductModel product) {
    variationStockStatus.value = selectedVariation.value.stock > 0
        ? 'In Stock'
        : 'Out of Stock';
  }

   String getVariationPrice() {
    return (selectedVariation.value.salePrice > 0?selectedVariation.value.salePrice:selectedVariation.value.price).toStringAsFixed(0);
  }
}
