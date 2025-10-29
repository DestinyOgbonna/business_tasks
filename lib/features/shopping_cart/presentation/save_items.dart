import 'dart:io';

import 'package:busniess_search/features/shopping_cart/data/add_items_provider.dart';
import 'package:busniess_search/model/item_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

class AddEditItemScreen extends StatefulWidget {
  final Item? item;
  final int? index;

  const AddEditItemScreen({Key? key, this.item, this.index}) : super(key: key);

  @override
  State<AddEditItemScreen> createState() => _AddEditItemScreenState();
}

class _AddEditItemScreenState extends State<AddEditItemScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;
  late String imagePath;

  @override
  void initState() {
    context.read<AddItemsProvider>().clearValues();

    super.initState();
    _nameController = TextEditingController(text: widget.item?.name ?? '');
    _descriptionController =
        TextEditingController(text: widget.item?.description ?? '');
    _priceController =
        TextEditingController(text: widget.item?.price.toString() ?? '');
    imagePath = widget.item?.imagePath ?? '';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.item != null;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          isEditing ? 'Update Item' : 'Add Item',
          style: GoogleFonts.montserrat(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: Consumer<AddItemsProvider>(builder: (context, itemsProvider, _) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  GestureDetector(
                    onTap: () async {
                      _showCameraDialog(context);
                    },
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: itemsProvider.profilePicture != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.file(
                                itemsProvider.profilePicture ?? File(''),
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Center(
                                    child: Icon(Icons.image_not_supported,
                                        size: 50),
                                  );
                                },
                              ),
                            )
                          : imagePath != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.file(
                                    File(imagePath),
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Center(
                                        child: Icon(Icons.image_not_supported,
                                            size: 50),
                                      );
                                    },
                                  ),
                                )
                              : const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.add_photo_alternate, size: 50),
                                    SizedBox(height: 8),
                                    Text('Tap to add image'),
                                  ],
                                ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.label),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.description),
                    ),
                    maxLines: 3,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a description';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _priceController,
                    decoration: const InputDecoration(
                      labelText: 'Price',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.attach_money),
                    ),
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a price';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Please enter a valid number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  GestureDetector(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        itemsProvider.saveItem(
                          context: context,
                          descriptionController: _descriptionController.text,
                          index: widget.index,
                          nameController: _nameController.text,
                          priceController: _priceController.text,
                        );
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.orange,
                      ),
                      child: Text(
                        isEditing ? 'Update Item' : 'Add Item',
                        style:
                            const TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  void _showCameraDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Item Image'),
        content: const Text(' Kindly Upload an Image '),
        actions: [
          TextButton(
            onPressed: () {
              context.read<AddItemsProvider>().takeCameraPicture(context);
              Navigator.pop(context);
            },
            child: const Text('Camera'),
          ),
          TextButton(
            onPressed: () {
              context.read<AddItemsProvider>().takeGalleryPicture(context);
              Navigator.pop(context);
            },
            child: const Text('Gallery', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
