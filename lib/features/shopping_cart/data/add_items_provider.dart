import 'dart:developer';
import 'dart:io';

import 'package:busniess_search/api/image_service.dart';
import 'package:busniess_search/features/shopping_cart/wdget/custom_toast.dart';
import 'package:busniess_search/model/item_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AddItemsProvider extends ChangeNotifier {
  String? imagePath;
  File? profilePicture;
  String profilePictureString = "";

  clearValues() {
    profilePicture = null;
    profilePictureString = "";
    typeOfImage = ImageType.asset;
  }

  ImageType typeOfImage = ImageType.asset;
  //PICK IMAGE

  void setImageType(ImageType type) {
    typeOfImage = type;
    notifyListeners();
  }

  Future<void> takeGalleryPicture(context) async {
    try {
      final image = await ImageService.pickImage(ImageUploadType.gallery);
      if (image == null) {
        CustomToast.show(
            message: 'No Image seleceted', isError: true, context: context);
        return;
      }
      log('$image');
      profilePicture = File(image.path);
      profilePictureString = image.path;
      setImageType(ImageType.file);
    } catch (e) {
      if (e is FileSystemException) {
        CustomToast.show(
            message: 'Invalid Image', isError: true, context: context);
      } else {
        CustomToast.show(
            message: 'Invalid Image', isError: true, context: context);
      }
    }
    notifyListeners();
  }

  Future<void> takeCameraPicture(context) async {
    try {
      final image = await ImageService.pickImage(ImageUploadType.camera);
      if (image == null) {
        CustomToast.show(
            message: 'No Image seleceted', isError: true, context: context);
        return;
      }
      log('$image');
      profilePicture = File(image.path);
      profilePictureString = image.path;
      setImageType(ImageType.file);
    } catch (e) {
      if (e is FileSystemException) {
        CustomToast.show(
            message: 'Invalid Image', isError: true, context: context);
      } else {
        CustomToast.show(
            message: 'Invalid Image', isError: true, context: context);
      }
    }
    notifyListeners();
  }

  saveItem(
      {required String nameController,
      required String descriptionController,
      required String? priceController,
      required BuildContext context,
      required int? index}) {
    final item = Item(
      name: nameController,
      description: descriptionController,
      price: double.parse(priceController ?? ''),
      imagePath: profilePictureString,
    );

    final box = Hive.box<Item>('items');

    if (index != null) {
      //Edit existing item
      box.putAt(index, item);
      CustomToast.show(
          message: 'Item Updated Successfully',
          isError: false,
          context: context);
      Navigator.pop(context);
    } else {
      // Add new item
      box.add(item);

      CustomToast.show(
          message: 'Item Added Successfully', isError: false, context: context);
      Navigator.pop(context);
    }
  }
}

enum ImageType { file, network, asset }
