import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../features/shop/models/product_model.dart';


class ProductUploadRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  CollectionReference<Map<String, dynamic>> get _productsRef =>
      _firestore.collection('products');

  /// Upload image to Firebase Storage and get URL
  Future<String> uploadImage(File file, String productId, String imageName) async {
    final ref = _storage.ref().child('products/$productId/$imageName');
    final uploadTask = await ref.putFile(file);
    return await uploadTask.ref.getDownloadURL();
  }

  /// Upload product to Firestore (with image URLs)
  Future<void> uploadProduct(ProductModel product, List<File> productImages) async {
    // Use Firestore doc id as product id
    DocumentReference docRef = product.id.isEmpty
        ? _productsRef.doc()
        : _productsRef.doc(product.id);

    String productId = docRef.id;

    List<String> imageUrls = [];

    // Upload all images
    for (int i = 0; i < productImages.length; i++) {
      String url = await uploadImage(productImages[i], productId, 'image_$i.jpg');
      imageUrls.add(url);
    }

    // Set thumbnail as first image if not set
    if (product.thumbnail.isEmpty && imageUrls.isNotEmpty) {
      product.thumbnail = imageUrls[0];
    }

    product.images = imageUrls;

    // Save to Firestore
    await docRef.set(product.toJson(), SetOptions(merge: true));
  }
}
