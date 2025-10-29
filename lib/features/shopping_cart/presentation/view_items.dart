import 'dart:io';

import 'package:busniess_search/features/business_card/theme_provider.dart';
import 'package:busniess_search/features/shopping_cart/presentation/save_items.dart';
import 'package:busniess_search/features/shopping_cart/presentation/shopping_cart.dart';
import 'package:busniess_search/model/item_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

class ItemsListScreen extends StatelessWidget {
  const ItemsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
            icon: Provider.of<ThemeProvider>(context, listen: false).isDarkMode
                ? const Icon(
                    Icons.light_mode,
                    color: Colors.yellow,
                  )
                : const Icon(Icons.dark_mode),
          )
        ],
      ),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: Hive.box<Item>('items').listenable(),
          builder: (context, Box<Item> box, _) {
            if (box.isEmpty) {
              return const Center(
                child: Text(
                  'No items yet.\nTap + to add one!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              );
            }

            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: BorderSide.strokeAlignCenter,
                  crossAxisSpacing: 4,
                  childAspectRatio: 0.74),
              padding: const EdgeInsets.all(8),
              itemCount: box.length,
              itemBuilder: (context, index) {
                final item = box.getAt(index);
                if (item == null) return const SizedBox();

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ShoppingCartScreen(
                          item: item,
                          index: index,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    margin:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        item.imagePath != null
                            ? Stack(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 10),
                                    width: double.infinity,
                                    height: 150,
                                    decoration: BoxDecoration(
                                      color: Colors.red[200],
                                      borderRadius: BorderRadius.circular(8),
                                      image: DecorationImage(
                                        image: FileImage(File(item.imagePath!)),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      right: 0,
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  AddEditItemScreen(
                                                item: item,
                                                index: index,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              color: Colors.black54,
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          padding: const EdgeInsets.all(8.0),
                                          child: const Icon(
                                            Icons.edit_outlined,
                                            color: Colors.white,
                                            size: 15,
                                          ),
                                        ),
                                      ))
                                ],
                              )
                            : const Icon(Icons.shopping_bag, size: 50),
                        //IMAGE
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            item.name,
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '\$${item.price.toStringAsFixed(2)}',
                                style: GoogleFonts.montserrat(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                _showDeleteDialog(context, index);
                              },
                              child: Container(
                                margin: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8)),
                                padding: const EdgeInsets.all(8.0),
                                child: const Icon(
                                  Icons.delete_outlined,
                                  color: Colors.red,
                                  size: 18,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddEditItemScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Item'),
        content: const Text('Are you sure you want to delete this item?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Hive.box<Item>('items').deleteAt(index);
              Navigator.pop(context);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
