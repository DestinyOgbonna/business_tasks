

import 'package:busniess_search/api/business_data.dart';
import 'package:busniess_search/model/business_model.dart';
import 'package:dio/dio.dart';
import 'dart:convert';


class BusinessService {

  Future<List<Business>> fetchBusinesses() async {
    try {
      // Simulate loading from local JSON file using Dio
      final response = await _loadLocalJsonData();
      
      final List<dynamic> jsonData = json.decode(response.data);
      return jsonData.map((json) => Business.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load businesses: $e');
    }
  }

  Future<Response> _loadLocalJsonData() async {
    await Future.delayed(const Duration(milliseconds: 800));
    return Response(
      data: BusinessData.jsonData,
      statusCode: 200,
      requestOptions: RequestOptions(path: '/assets/data/businesses.json'),
    );
  }

  Future<List<Business>> searchBusinesses(String query) async {
    final businesses = await fetchBusinesses();
    
    if (query.isEmpty) {
      return businesses;
    }

    final lowercaseQuery = query.toLowerCase();
    return businesses.where((business) {
      return business.name.toLowerCase().contains(lowercaseQuery) ||
             business.category.toLowerCase().contains(lowercaseQuery) ||
             business.description.toLowerCase().contains(lowercaseQuery) ||
             business.services.any((service) => 
               service.toLowerCase().contains(lowercaseQuery));
    }).toList();
  }
}
