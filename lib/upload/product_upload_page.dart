import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../features/shop/models/product_model.dart';
import 'controller/product_upload_controller.dart';


class ProductUploadPage extends StatefulWidget {
  const ProductUploadPage({super.key});

  @override
  State<ProductUploadPage> createState() => _ProductUploadPageState();
}

class _ProductUploadPageState extends State<ProductUploadPage> {
  final ProductUploadController _controller = Get.put(ProductUploadController.instance);

  final TextEditingController titleController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController stockController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  List<File> pickedImages = [];
  final picker = ImagePicker();

  Future<void> pickImages() async {
    final pickedFiles = await picker.pickMultiImage();
    if (pickedFiles != null) {
      setState(() {
        pickedImages = pickedFiles.map((x) => File(x.path)).toList();
      });
    }
  }

  void uploadProduct() {
    if (titleController.text.isEmpty || priceController.text.isEmpty || pickedImages.isEmpty) {
      Get.snackbar('Error', 'Please fill title, price and pick at least one image');
      return;
    }

    ProductModel product = ProductModel(
      id: '',
      title: titleController.text,
      stock: int.tryParse(stockController.text) ?? 0,
      price: double.tryParse(priceController.text) ?? 0.0,
      salePrice: 0.0,
      thumbnail: '',
      productType: 'single',
      description: descriptionController.text,
    );

    _controller.uploadProductWithImages(product, pickedImages);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upload Product')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: titleController, decoration: const InputDecoration(labelText: 'Title')),
            TextField(controller: priceController, decoration: const InputDecoration(labelText: 'Price'), keyboardType: TextInputType.number),
            TextField(controller: stockController, decoration: const InputDecoration(labelText: 'Stock'), keyboardType: TextInputType.number),
            TextField(controller: descriptionController, decoration: const InputDecoration(labelText: 'Description')),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: pickImages, child: const Text('Pick Images')),
            const SizedBox(height: 10),
            pickedImages.isNotEmpty
                ? SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: pickedImages.length,
                itemBuilder: (_, i) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.file(pickedImages[i]),
                ),
              ),
            )
                : const Text('No images selected'),
            const SizedBox(height: 20),
            Obx(() => _controller.isUploading.value
                ? Column(
              children: [
                const Text('Uploading...'),
                LinearProgressIndicator(value: _controller.progress.value),
              ],
            )
                : ElevatedButton(onPressed: uploadProduct, child: const Text('Upload Product'))),
          ],
        ),
      ),
    );
  }
}
