import 'package:busniess_search/features/business_search/data/business_search_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryFilterWidget extends StatelessWidget {
  const CategoryFilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BusinessProvider>(
      builder: (context, provider, child) {
        final categories = provider.getCategories();

        if (categories.length <= 1) {
          return const SizedBox.shrink();
        }

        return SizedBox(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: FilterChip(
                  label: Text(category),
                  onSelected: (selected) {
                    provider.filterByCategory(category);
                  },
                  selected:
                      false, // You can add logic to track selected category
                ),
              );
            },
          ),
        );
      },
    );
  }
}
