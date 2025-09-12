import 'package:busniess_search/api/api_service.dart';
import 'package:busniess_search/model/business_model.dart';
import 'package:flutter/material.dart';

class BusinessProvider with ChangeNotifier {
  final BusinessService _businessService = BusinessService();

  List<Business> _allBusinesses = [];
  List<Business> _filteredBusinesses = [];
  bool _isLoading = false;
  String _errorMessage = '';
  String _searchQuery = '';

  // Getters
  List<Business> get allBusinesses => _allBusinesses;
  List<Business> get filteredBusinesses => _filteredBusinesses;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  String get searchQuery => _searchQuery;
  bool get hasError => _errorMessage.isNotEmpty;
  bool get hasBusinesses => _filteredBusinesses.isNotEmpty;

  // Initialize and load businesses
  Future<void> loadBusinesses() async {
    _setLoading(true);
    _clearError();

    try {
      _allBusinesses = await _businessService.fetchBusinesses();
      _filteredBusinesses = List.from(_allBusinesses);

      // Apply current search if any
      if (_searchQuery.isNotEmpty) {
        _performSearch(_searchQuery);
      }
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  // Search functionality
  void searchBusinesses(String query) {
    _searchQuery = query;
    _performSearch(query);
    notifyListeners();
  }

  void _performSearch(String query) {
    if (query.isEmpty) {
      _filteredBusinesses = List.from(_allBusinesses);
    } else {
      final lowercaseQuery = query.toLowerCase();
      _filteredBusinesses = _allBusinesses.where((business) {
        return business.name.toLowerCase().contains(lowercaseQuery) ||
            business.category.toLowerCase().contains(lowercaseQuery) ||
            business.description.toLowerCase().contains(lowercaseQuery) ||
            business.services.any(
                (service) => service.toLowerCase().contains(lowercaseQuery));
      }).toList();
    }
  }

  // Clear search
  void clearSearch() {
    _searchQuery = '';
    _filteredBusinesses = List.from(_allBusinesses);
    notifyListeners();
  }

  // Filter by category
  void filterByCategory(String category) {
    if (category.isEmpty || category == 'All') {
      _filteredBusinesses = List.from(_allBusinesses);
    } else {
      _filteredBusinesses = _allBusinesses
          .where((business) => business.category == category)
          .toList();
    }
    notifyListeners();
  }

  // Get unique categories
  List<String> getCategories() {
    final categories = _allBusinesses.map((b) => b.category).toSet().toList();
    categories.sort();
    return ['All', ...categories];
  }

  // Helper methods
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _errorMessage = error;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = '';
  }

  // Retry loading
  Future<void> retry() async {
    await loadBusinesses();
  }
}
