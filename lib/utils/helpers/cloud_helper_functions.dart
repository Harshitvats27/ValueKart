import 'package:e_commerce_application/utils/helpers/u_empty_state_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

import '../../pan_india_catalog.dart';

class UCloudHelperFunctions {

  static Widget? checkSingleRecordState<T>(AsyncSnapshot<T> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    }

    if (!snapshot.hasData || snapshot.data == null) {
      return const UEmptyStateWidget(
        icon: CupertinoIcons.info_circle,
        title: "No Data Found 📭",
        subTitle: "We couldn't find any information here right now.",
      );
    }

    if (snapshot.hasError) {
      return const Center(child: Text('Something went wrong.'));
    }

    return null;
  }

  static Widget? checkMultiRecordState<T>({
    required AsyncSnapshot<List<T>> snapshot,
    Widget? loader,
    Widget? error,
    Widget? nothingFound, // 🔥 Iska use karenge hum screens se!
  }) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      if (loader != null) return loader;
      return const Center(child: CircularProgressIndicator());
    }

    if (!snapshot.hasData || snapshot.data == null || snapshot.data!.isEmpty) {
      // 🔥 AGAR SCREEN SE CUSTOM WIDGET BHEJA HAI, TOH WAHI DIKHEGA:
      if (nothingFound != null) return nothingFound;

      // 🔥 WARNA YE UNIVERSAL DEFAULT DIKHEGA:
      return UEmptyStateWidget(
        icon: Iconsax.search_status,
        title: "Nothing Found Here 🔍",
        subTitle: "There is no data available in this section yet.",
        showAction: true,
        actionTitle: "Explore Pan-India Catalog 🌍",
        onActionPressed: () => Get.to(() => const PanIndiaCatalogScreen()),
      );
    }

    if (snapshot.hasError) {
      if (error != null) return error;
      return const Center(child: Text('Something went wrong.'));
    }

    return null;
  }
}