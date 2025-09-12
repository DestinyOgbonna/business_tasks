import 'package:busniess_search/features/business_search/data/business_search_provider.dart';
import 'package:busniess_search/features/business_search/presentation/widgets/business_card_widget.dart';
import 'package:busniess_search/features/business_search/presentation/widgets/business_details_bottomsheet.dart';
import 'package:busniess_search/features/business_search/presentation/widgets/categories_widget.dart';
import 'package:busniess_search/features/business_search/presentation/widgets/search_bar_widgets.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BusinessSearchScreen extends StatefulWidget {
  const BusinessSearchScreen({super.key});

  @override
  _BusinessSearchScreenState createState() => _BusinessSearchScreenState();
}

class _BusinessSearchScreenState extends State<BusinessSearchScreen> {
  @override
  void initState() {
    super.initState();
    // Load businesses when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BusinessProvider>().loadBusinesses();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Business Search'),
        backgroundColor: Colors.blue[600],
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      body: Column(
        children: [
         const SearchBarWidget(),
          const CategoryFilterWidget(),
          Expanded(
            child: _buildContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Consumer<BusinessProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return _buildLoadingState();
        }

        if (provider.hasError) {
          return _buildErrorState(provider);
        }

        if (!provider.hasBusinesses) {
          return _buildEmptyState();
        }

        return _buildBusinessList(provider);
      },
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('Loading businesses...'),
        ],
      ),
    );
  }

  Widget _buildErrorState(BusinessProvider provider) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: Colors.red),
          const SizedBox(height: 16),
          const Text(
            'Error loading businesses',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              provider.errorMessage,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => provider.retry(),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'No businesses found',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text('Try adjusting your search terms or filters'),
        ],
      ),
    );
  }

  Widget _buildBusinessList(BusinessProvider provider) {
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: provider.filteredBusinesses.length,
      itemBuilder: (context, index) {
        final business = provider.filteredBusinesses[index];
        return BusinessCardWidget(
          business: business,
          onTap: () => _showBusinessDetails(business),
        );
      },
    );
  }

  void _showBusinessDetails(business) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => BusinessDetailModal(business: business),
    );
  }
}








